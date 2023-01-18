defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Mario", :chute, :soco, :cura)
      computer = Player.build("Browser Jr", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Mario", :chute, :soco, :cura)
      computer = Player.build("Browser Jr", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Browser Jr"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Mario"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build("Mario", :chute, :soco, :cura)
      computer = Player.build("Browser Jr", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Browser Jr"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Mario"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response

      new_state = %{
        computer: %Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Browser Jr"
        },
        player: %Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Mario"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | status: :continue, turn: :computer}

      assert Game.info() == expected_response
    end
  end

  describe "player/0" do
    test "returns game's player" do
      player = Player.build("Mario", :chute, :soco, :cura)
      computer = Player.build("Browser Jr", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Mario"
      }

      assert Game.player() == expected_response
    end
  end

  describe "turn/0" do
    test "returns game's current turn" do
      player = Player.build("Mario", :chute, :soco, :cura)
      computer = Player.build("Browser Jr", :chute, :soco, :cura)
      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/1" do
    test "returns game's computer" do
      player = Player.build("Mario", :chute, :soco, :cura)
      computer = Player.build("Browser Jr", :chute, :soco, :cura)
      Game.start(computer, player)

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Browser Jr"
      }

      assert Game.fetch_player(:computer) == expected_response
    end
  end
end
