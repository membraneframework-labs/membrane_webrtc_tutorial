// We'll put the code within an async function, so we could use await
async function init() {
  const localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
  document.querySelector('#local-video').srcObject = localStream;
  const peerConnection = new RTCPeerConnection({
    bundlePolicy: "max-bundle",
    iceServers: [
      // { urls: 'stun:stun.l.google.com:19302' },
      { urls: 'stun:turn.membraneframework.org:19302' },
      {
        urls: [
          'turn:turn.membraneframework.org?transport=udp',
          'turn:turn.membraneframework.org?transport=tcp',
          'turns:turn.membraneframework.org:443?transport=tcp',
        ],
        username: 'turn',
        credential: 'PASSWORD'
      },
    ],
    // iceTransportPolicy: 'relay'
    iceTransportPolicy: 'all'
  });
  localStream.getTracks().forEach(track => {
    peerConnection.addTrack(track, localStream);
  });
  const offer = await peerConnection.createOffer();
  peerConnection.onicecandidate = (event) => console.log(event.candidate);
  await peerConnection.setLocalDescription(offer);
}

init();
