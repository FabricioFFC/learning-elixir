import Config

config :geolocation_service, ecto_repos: [GeolocationService.Repo]

config :geolocation_service,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :geolocation_service, GeolocationServiceWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [json: GeolocationServiceWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: GeolocationApi.PubSub,
  live_view: [signing_salt: System.fetch_env!("SIGNING_SALT")]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
