defmodule WebrtcTutorialWeb.Router do
  use WebrtcTutorialWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {WebrtcTutorialWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WebrtcTutorialWeb do
    pipe_through :browser

    get "/", PageController, :index
  end
end
