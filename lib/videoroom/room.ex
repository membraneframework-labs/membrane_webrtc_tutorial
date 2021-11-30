defmodule VideoRoom.Room do
  use GenServer

  @impl true
  def init(_options) do
    Process.register(self(), __MODULE__)
    peers = []
    {:ok, peers}
  end

  @impl true
  def handle_info({:join, pid}, peers) do
    if peers != [] do
      send(pid, {:signal, "plox_send_offer_sir", %{}})
    end

    {:noreply, [pid | peers]}
  end

  @impl true
  def handle_info({:signal, message_type, message_payload, pid}, peers) do
    peer_pid = Enum.find(peers, fn peer_pid -> peer_pid != pid end)
    send(peer_pid, {:signal, message_type, message_payload})
    {:noreply, peers}
  end
end
