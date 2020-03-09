defmodule ElixirRestApiWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :elixir_rest_api

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_elixir_rest_api_key",
    signing_salt: "j5Ap2gCZ"
  ]

  socket "/socket",
         ElixirRestApiWeb.UserSocket,
         websocket: true,
         longpoll: false


  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
       parsers: [:urlencoded, :multipart, :json],
       pass: ["application/json"],
       json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug ElixirRestApiWeb.Router

  def init(_key, config) do
    if config[:loac_from_system_env] do
      port = Application.get_env(:elixir_rest_api, :app_port) || raise "expected the PORT environment var to be set"
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
