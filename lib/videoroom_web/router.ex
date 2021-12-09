defmodule VideoRoomWeb.Router do
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  scope "/", VideoRoomWeb do
    get "/", PageController, :index
    get "/*path", PageController, :missing
  end
end

defmodule VideoRoomWeb.PageController do
  use Phoenix.Controller, namespace: VideoRoomWeb
  import Plug.Conn

  def index(conn, _params) do
    redirect(conn, to: "/index.html")
  end

  def missing(conn, _params) do
    send_resp(conn, 404, "Not Found")
  end
end
