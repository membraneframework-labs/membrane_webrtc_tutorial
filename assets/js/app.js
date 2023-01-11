import "../css/app.css"

import "phoenix_html"

import { Socket } from "phoenix"

// We'll put the code within an async function, so we could use await
async function init() {
  const localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
  document.querySelector('#local-video').srcObject = localStream;
  const peerConnection = new RTCPeerConnection();
  localStream.getTracks().forEach(track => {
    peerConnection.addTrack(track, localStream);
  });
  const offer = await peerConnection.createOffer();
  console.log(offer.sdp);
}

init();
