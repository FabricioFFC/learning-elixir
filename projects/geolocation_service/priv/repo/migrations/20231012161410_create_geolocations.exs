defmodule GeolocationService.Repo.Migrations.CreateGeolocations do
  use Ecto.Migration

  def change do
    create table(:geolocations) do
      add :ip_address, :inet
      add :country_code, :string
      add :country, :string
      add :city, :string
      add :latitude, :float
      add :longitude, :float
      add :mystery_value, :bigint

      timestamps()
    end

    create index(:geolocations, [:ip_address], unique: true)
  end
end
