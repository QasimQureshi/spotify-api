# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :spotifyapi, SpotifyapiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QKvmAg3KQIjy5kHGHN+oyWM9oaFZ2NkuxoJluq+HgzZLhiCVMj9mNYc8w3FAiGhD",
  render_errors: [view: SpotifyapiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Spotifyapi.PubSub,
  live_view: [signing_salt: "e6M+uMyw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
import_config "spotify.exs"
import_config "secret.exs"