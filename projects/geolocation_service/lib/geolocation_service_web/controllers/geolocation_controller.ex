defmodule GeolocationServiceWeb.GeolocationController do
  use GeolocationServiceWeb, :controller

  alias GeolocationService.{Geolocation, Repo}

  action_fallback(GeolocationServiceWeb.FallbackController)

  def show(conn, %{"ip_address" => ip_address}) do
    geolocation = Repo.get_by(Geolocation, ip_address: ip_address)

    if geolocation do
      render(conn, :show, geolocation: geolocation)
    else
      {:error, :not_found}
    end
  end
end
