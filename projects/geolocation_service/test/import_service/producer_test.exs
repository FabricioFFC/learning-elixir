defmodule ImportServiceProducerTest do
  use ExUnit.Case, async: true

  alias GeolocationService.{Geolocation, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "import" do
    test "import the valid rows" do
      import_result = ImportService.Producer.import("test/fixtures/geoip.csv")

      count_result = Repo.aggregate(Geolocation, :count)

      assert %{accepted_count: 3, discarded_count: 5, elapsed_time: _} = import_result

      assert count_result == 3
    end
  end
end
