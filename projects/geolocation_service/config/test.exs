import Config

# Configure your database
config :geolocation_service, GeolocationService.Repo,
  database: "geolocation_service_test",
  username: System.get_env("DATABASE_USER"),
  password: System.get_env("DATABASE_PASSWORD"),
  hostname: System.get_env("DATABASE_HOST"),
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  log: false

config :logger, level: :warning
