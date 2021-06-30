# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elxpro_k8s,
  ecto_repos: [ElxproK8s.Repo]

# Configures the endpoint
config :elxpro_k8s, ElxproK8sWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZKK8FVJrpt/u0EVEA2XKiaXFkZ2XJgvYV1QZB8XwVijmCRdmxgn77PojxNP4ubYH",
  render_errors: [view: ElxproK8sWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElxproK8s.PubSub,
  live_view: [signing_salt: "6cES4FGI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
