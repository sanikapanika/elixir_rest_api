# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_rest_api,
  ecto_repos: [ElixirRestApi.Repo]

# Configures the endpoint
config :elixir_rest_api, ElixirRestApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nD2/X1tNhHalEsrEemBuzPMIWI3a1rBrySo9MYpkWuyO8xl8yupFhbEQgX6qFaq0",
  render_errors: [view: ElixirRestApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ElixirRestApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :elixir_rest_api, ElixirRestApiWeb.Auth.Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "elixir_rest_api",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: "upfJUSoztnas6qmT+VsjdrCQ9joW4k78gGANxikNHKJTCJAWSLJOfDH59k6kLLsZ"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
