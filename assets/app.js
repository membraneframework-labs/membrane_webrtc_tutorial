// We'll put the code within an async function, so we could use await
async function init() {
  const localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: false });
  document.querySelector('#local-video').srcObject = localStream;
  const peerConnection = new RTCPeerConnection({ iceServers: [{ urls: ['stun:stun1.l.google.com:19302', 'stun:stun2.l.google.com:19302',] }] });
  localStream.getTracks().forEach(track => {
    peerConnection.addTrack(track, localStream);
  });
  const offer = await peerConnection.createOffer();
  const socket = new Phoenix.Socket("/socket");
  await socket.connect();
  const channel = socket.channel('room');
  channel.on("plox_send_offer_sir", async (_data) => {
    channel.push("sdp_offer", offer);
    await peerConnection.setLocalDescription(offer);
  })
  channel.on("sdp_answer", async (data) => await peerConnection.setRemoteDescription(data));
  channel.on("sdp_offer", async (data) => {
    await peerConnection.setRemoteDescription(data);
    const answer = await peerConnection.createAnswer();
    channel.push("sdp_answer", answer);
    await peerConnection.setLocalDescription(answer);
  });
  channel.on("ice_candidate", async (data) => await peerConnection.addIceCandidate(data));
  peerConnection.onicecandidate = (event) => channel.push("ice_candidate", event.candidate);
  peerConnection.ontrack = (event) => document.querySelector('#remote-video').srcObject = event.streams[0];
  await channel.join();
}

init();
