defmodule WebrtcTutorialWeb.PageController do
  use WebrtcTutorialWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
