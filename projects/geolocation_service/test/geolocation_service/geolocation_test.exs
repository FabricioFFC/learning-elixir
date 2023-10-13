defmodule GeolocationServiceGeolocationTest do
  use GeolocationService.EctoCase, async: true

  alias GeolocationService.{Geolocation, Repo}

  import GeolocationService.Factory

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "changeset" do
    test "returns a changeset with no errors when the geolocation is valid" do
      geolocation = build(:geolocation)

      changeset = Geolocation.changeset(geolocation)

      assert changeset.valid?
      assert changeset.errors == []
    end

    test "returns a changeset with no errors when the geolocation is valid with latitude and longitude in their negative limits" do
      geolocation = build(:geolocation, latitude: -90, longitude: -180)

      changeset = Geolocation.changeset(geolocation)

      assert changeset.valid?
      assert changeset.errors == []
    end

    test "returns a changeset with no errors when the geolocation is valid with latitude and longitude in their positive limits" do
      geolocation = build(:geolocation, latitude: 90, longitude: 180)

      changeset = Geolocation.changeset(geolocation)

      assert changeset.valid?
      assert changeset.errors == []
    end

    test "returns errors when required params are not passed" do
      geolocation = %{}

      changeset = Geolocation.changeset(%Geolocation{}, geolocation)

      assert errors_on(changeset) == %{
               ip_address: ["is not a valid IP address", "can't be blank"],
               latitude: ["must be between -90 and 90", "can't be blank"],
               longitude: ["must be between -180 and 180", "can't be blank"],
               mystery_value: ["can't be blank"]
             }
    end

    test "returns a changeset with an error when the IP address is invalid" do
      geolocation = build(:geolocation, ip_address: "not an IP address")

      changeset = Geolocation.changeset(geolocation)

      assert changeset.valid? == false

      assert changeset.errors == [
               ip_address: {"is not a valid IP address", []}
             ]
    end

    test "returns a changeset with an error when the latitude is -91" do
      geolocation = build(:geolocation, latitude: 91)

      changeset = Geolocation.changeset(geolocation)

      assert changeset.valid? == false

      assert changeset.errors == [
               latitude: {"must be between -90 and 90", []}
             ]
    end

    test "returns a changeset with an error when the latitude is 91" do
      geolocation = build(:geolocation, latitude: 91)

      changeset = Geolocation.changeset(geolocation)

      assert changeset.valid? == false

      assert changeset.errors == [
               latitude: {"must be between -90 and 90", []}
             ]
    end

    test "returns a changeset with an error when the longitude is -181" do
      geolocation = build(:geolocation, longitude: -181)

      changeset = Geolocation.changeset(geolocation)

      assert changeset.valid? == false

      assert changeset.errors == [
               longitude: {"must be between -180 and 180", []}
             ]
    end

    test "returns a changeset with an error when the longitude is 181" do
      geolocation = build(:geolocation, longitude: 181)

      changeset = Geolocation.changeset(geolocation)

      assert changeset.valid? == false

      assert changeset.errors == [
               longitude: {"must be between -180 and 180", []}
             ]
    end

    test "returns a changeset with an error when the IP address is not unique" do
      changeset = Geolocation.changeset(%Geolocation{}, params_for(:geolocation))

      Repo.insert!(changeset)

      new_changeset = Geolocation.changeset(%Geolocation{}, params_for(:geolocation))

      {:error, changeset} = Repo.insert(new_changeset)

      assert changeset.valid? == false

      assert changeset.errors == [
               ip_address:
                 {"has already been taken",
                  [{:constraint, :unique}, {:constraint_name, "geolocations_ip_address_index"}]}
             ]
    end
  end
end
