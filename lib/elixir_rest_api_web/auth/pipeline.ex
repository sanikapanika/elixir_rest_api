defmodule ElixirRestApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
      otp_app: :elixir_rest_api,
      module: ElixirRestApiWeb.Auth.Guardian,
      error_handler: ElixirRestApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end