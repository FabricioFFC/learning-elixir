defmodule GeolocationService.Geolocation do
  @moduledoc """
  Geolocation to validate and persist geolocation data.
  """
  use Ecto.Schema

  require IP

  import Ecto.Changeset
  import EctoNetwork

  @params [:ip_address, :country_code, :country, :city, :latitude, :longitude, :mystery_value]
  @required_params [:ip_address, :latitude, :longitude, :mystery_value]

  schema "geolocations" do
    field(:ip_address, EctoNetwork.INET)
    field(:country_code, :string)
    field(:country, :string)
    field(:city, :string)
    field(:latitude, :float)
    field(:longitude, :float)
    field(:mystery_value, :integer)

    timestamps()
  end

  def changeset(%__MODULE__{} = geolocation, attrs \\ %{}) do
    geolocation
    |> cast(attrs, @params)
    |> validate_required(@required_params)
    |> validate_latitude()
    |> validate_longitude()
    |> validate_ip()
    |> unique_constraint(:ip_address)
  end

  defp validate_ip(changeset) do
    get_field(changeset, :ip_address)
    |> validate_ip_address(changeset)
  end

  defp validate_ip_address(ip_address, changeset) do
    "#{ip_address}"
    |> IP.from_string()
    |> validate_parsed_ip(changeset)
  end

  defp validate_latitude(changeset) do
    get_field(changeset, :latitude)
    |> validate_latitude_value(changeset)
  end

  def validate_latitude_value(latitude, changeset) do
    case latitude >= -90 && latitude <= 90 do
      true -> changeset
      false -> add_error(changeset, :latitude, "must be between -90 and 90")
    end
  end

  defp validate_longitude(changeset) do
    get_field(changeset, :longitude)
    |> validate_longitude_value(changeset)
  end

  def validate_longitude_value(longitude, changeset) do
    case longitude >= -180 && longitude <= 180 do
      true -> changeset
      false -> add_error(changeset, :longitude, "must be between -180 and 180")
    end
  end

  defp validate_parsed_ip({:ok, parsed_ip}, changeset) do
    case IP.is_ip(parsed_ip) do
      true -> changeset
      false -> add_ip_address_error(changeset)
    end
  end

  defp validate_parsed_ip({:error, _}, changeset) do
    add_ip_address_error(changeset)
  end

  defp add_ip_address_error(changeset) do
    add_error(changeset, :ip_address, "is not a valid IP address")
  end
end
