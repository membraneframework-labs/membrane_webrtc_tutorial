defmodule VideoRoomWeb.PeerChannel do
  use Phoenix.Channel

  require Logger

  @impl true
  def join("room", _params, socket) do
    send(VideoRoom.Room, {:join, self()})
    send(self(), :join)
    {:ok, socket}
  end

  @impl true
  def handle_info(:join, socket) do
    push(socket, "plox_send_offer_sir", %{})
    {:ok, socket}
  end

  @impl true
  def handle_in(message_type, _message_payload, socket) do
    Logger.info("Received message #{message_type}")
    {:noreply, socket}
  end
end
