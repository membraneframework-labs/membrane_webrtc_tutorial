defmodule VideoRoom.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      %{
        id: VideoRoom.Room,
        start: {GenServer, :start_link, [VideoRoom.Room, []]}
      },
      VideoRoomWeb.Endpoint,
      {Phoenix.PubSub, name: VideoRoom.PubSub}
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
