import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :webrtc_tutorial, WebrtcTutorialWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "dym7RJNJYofy+DfvH1u3IPwYlNjWq7TTXxV4J/z7U+qJHVa4oewgL08HqGJai27h",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
