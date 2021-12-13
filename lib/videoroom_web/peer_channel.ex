defmodule VideoRoomWeb.PeerChannel do
  use Phoenix.Channel

  require Logger

  @impl true
  def join("room", _params, socket) do
    send(VideoRoom.Room, {:join, self()})
    {:ok, socket}
  end

  @impl true
  def handle_in(message_type, message_payload, socket) do
    Logger.info("Received message #{message_type}")
    send(VideoRoom.Room, {:signal, message_type, message_payload, self()})
    {:noreply, socket}
  end

  @impl true
  def handle_info({:signal, message_type, message_payload}, socket) do
    push(socket, message_type, message_payload)
    {:noreply, socket}
  end
end
