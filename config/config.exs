# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :magic_decks,
  ecto_repos: [MagicDecks.Repo]

# Configures the endpoint
config :magic_decks, MagicDecksWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "J16X80n594LxHEojMWLR8TkvImZh1w/TIneWhxpPDyVgUL8Fh3VF9yvge2KXoIPZ",
  render_errors: [view: MagicDecksWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: MagicDecks.PubSub,
  live_view: [signing_salt: "Z/Y8ZNTK"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
