defmodule ImportServiceStatisticsTest do
  use ExUnit.Case, async: false

  alias ImportService.Statistics

  setup do
    {:ok, agent} = Statistics.start_link(name: :test_statistics)

    {:ok, agent: agent}
  end

  describe "start_link" do
    test "starts the agent with the correct initial state", %{agent: agent} do
      assert %{accepted_count: 0, discarded_count: 0, elapsed_time: _} =
               Statistics.get_statistics(agent)
    end
  end

  describe "get_statistics" do
    test "returns the correct statistics", %{agent: agent} do
      Statistics.increment_accepted_count(agent)
      Statistics.increment_discarded_count(agent)
      Statistics.increment_discarded_count(agent)

      assert %{accepted_count: 1, discarded_count: 2, elapsed_time: _} =
               Statistics.get_statistics(agent)
    end
  end

  describe "increment_accepted_count" do
    test "increments the accepted count", %{agent: agent} do
      Statistics.increment_accepted_count(agent)
      Statistics.increment_accepted_count(agent)

      assert %{accepted_count: 2, discarded_count: 0, elapsed_time: _} =
               Statistics.get_statistics(agent)
    end
  end

  describe "increment_discarded_count" do
    test "increments the discarded count", %{agent: agent} do
      Statistics.increment_discarded_count(agent)
      Statistics.increment_discarded_count(agent)
      Statistics.increment_discarded_count(agent)

      assert %{accepted_count: 0, discarded_count: 3, elapsed_time: _} =
               Statistics.get_statistics(agent)
    end
  end
end
