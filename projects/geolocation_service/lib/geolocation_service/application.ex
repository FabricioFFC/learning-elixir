defmodule GeolocationService.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GeolocationService.Repo,
      GeolocationServiceWeb.Telemetry,
      {Phoenix.PubSub, name: GeolocationApi.PubSub},
      # Start a worker by calling: GeolocationApi.Worker.start_link(arg)
      # {GeolocationApi.Worker, arg},
      # Start to serve requests, typically the last entry
      GeolocationServiceWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GeolocationApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GeolocationServiceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
