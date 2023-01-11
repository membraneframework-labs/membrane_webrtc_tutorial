import "../css/app.css"

import "phoenix_html"

import { Socket } from "phoenix"

// We'll put the code within an async function, so we could use await
async function init() {
  const localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: false });
  document.querySelector('#local-video').srcObject = localStream;
  const peerConnection = new RTCPeerConnection({ iceServers: [{ urls: ['stun:stun1.l.google.com:19302', 'stun:stun2.l.google.com:19302',] }] });
  localStream.getTracks().forEach(track => {
    peerConnection.addTrack(track, localStream);
  });
  const offer = await peerConnection.createOffer();
  const socket = new Socket("/socket");
  socket.connect();
  const channel = socket.channel('room');
  channel.join();
  peerConnection.onicecandidate = e => channel.push("ice_candidate", e.candidate);
  channel.push("sdp_offer", offer);
  await peerConnection.setLocalDescription(offer);
}

init();
