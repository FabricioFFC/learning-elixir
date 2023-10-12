import Config

config :geolocation_service, ecto_repos: [GeolocationService.Repo]

import_config "#{config_env()}.exs"
