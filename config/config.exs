# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :checkboxes_ex,
  ecto_repos: [CheckboxesEx.Repo]

# Configures the endpoint
config :checkboxes_ex, CheckboxesEx.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "IMOs9375FkEmuIEy5hfZAJvXE4BC/l01HQ1YGtnUF7nrp7gsROiplzvLA7hyQCwR",
  render_errors: [view: CheckboxesEx.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CheckboxesEx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
