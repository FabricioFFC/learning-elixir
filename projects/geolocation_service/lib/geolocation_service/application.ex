defmodule GeolocationService.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GeolocationService.Repo
    ]

    opts = [strategy: :one_for_one, name: GeolocationService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end