defmodule ExMon.Game.Actions.HealTest do
  use ExUnit.Case

  import ExUnit.CaptureIO
  import Mock

  alias ExMon.Game
  alias ExMon.Game.Actions.Heal, as: ActionHeal

  describe "heal/1" do
    test "when the player heals itself prints the heal message" do
      player = %{name: "John", life: 99}

      with_mocks(mock_game_state(player)) do
        assert capture_io(fn ->
                 ActionHeal.heal_life(:player)
               end) =~ "The player healed itself to 100 life points."
      end
    end

    test "when the player heals itself and life is already at max prints the heal message" do
      player = %{name: "John", life: 100}

      with_mocks(mock_game_state(player)) do
        assert capture_io(fn ->
                 ActionHeal.heal_life(:player)
               end) =~ "The player healed itself to 100 life points."
      end
    end
  end

  defp mock_game_state(player) do
    [
      {
        Game,
        [],
        [
          fetch_player: fn _p -> player end,
          update: fn _p -> :ok end,
          info: fn -> %{player: player, computer: player} end
        ]
      }
    ]
  end
end
