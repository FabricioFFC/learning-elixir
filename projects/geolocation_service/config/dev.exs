import Config

# Configure your database
config :geolocation_service, GeolocationService.Repo,
  database: "geolocation_service_development",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
