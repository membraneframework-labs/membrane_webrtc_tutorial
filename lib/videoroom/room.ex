defmodule VideoRoom.Room do
  use GenServer

  @impl true
  def init(_options) do
    Process.register(self(), __MODULE__)
    peers = []
    {:ok, peers}
  end
end
