# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :toplists,
  ecto_repos: [Toplists.Repo]

# Configures the endpoint
config :toplists, Toplists.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "comN8Q6ygVMUhpvI2W1uP0+1lGErtmozDJp0XoYk+8xWT+jqgi/ylX4wlPGUZJUi",
  render_errors: [view: Toplists.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Toplists.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
