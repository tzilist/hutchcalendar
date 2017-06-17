# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hutch_calendar,
  ecto_repos: [HutchCalendar.Repo]

# Configures the endpoint
config :hutch_calendar, HutchCalendar.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ImQW9AvEoBnTtAzsInM0QN1j6vgL9SB+ZW56AXKQ5JIYezhVpA1PbMDXNujg4nXE",
  render_errors: [view: HutchCalendar.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HutchCalendar.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
