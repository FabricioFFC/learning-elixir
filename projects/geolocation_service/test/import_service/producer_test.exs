defmodule ImportServiceProducerTest do
  use ExUnit.Case

  alias GeolocationService.{Geolocation, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "import the valid rows" do
    ImportService.Producer.import("test/fixtures/geoip.csv")

    count_result = Repo.aggregate(Geolocation, :count)

    assert count_result == 3
  end
end
