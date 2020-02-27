defmodule ElixirRestApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
      otp_app: :elixir_rest_api,
      module: ElixirRestApiWeb.Auth.Guardian,
      error_handler: ElixirRestApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifySession,
       claims: %{
         "typ" => "access"
       }
  plug Guardian.Plug.VerifyHeader,
       claims: %{
         "typ" => "access"
       }
  plug Guardian.Plug.LoadResource, allow_blank: true

  plug Guardian.Permissions.Plug,
       one_of: [
         %{default: [:admin], user_actions: [:write]},
       ]

end