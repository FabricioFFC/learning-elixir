defmodule GeolocationService.Factory do
  @moduledoc """
    This module uses `ex_machina` to define factories.
  """

  use ExMachina.Ecto

  alias GeolocationService.Geolocation

  def geolocation_factory do
    %Geolocation{
      ip_address: "192.168.0.1",
      country_code: "US",
      country: "United States",
      city: "New York",
      latitude: 40.7128,
      longitude: 74.0060,
      mystery_value: 42
    }
  end
end
