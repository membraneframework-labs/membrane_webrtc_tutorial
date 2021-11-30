defmodule VideoRoomWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :membrane_videoroom_demo

  socket("/socket", VideoRoomWeb.UserSocket,
    websocket: true,
    longpoll: false
  )

  plug(Plug.Static,
    at: "/",
    from: "assets",
    brotli: true,
    gzip: true
  )

  plug(Plug.Parsers,
    parsers: [
      :urlencoded,
      :multipart,
      :json,
      Absinthe.Plug.Parser
    ],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()
  )
end
