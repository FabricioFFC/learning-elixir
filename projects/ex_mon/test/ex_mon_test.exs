defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Joel"
      }
      assert ExMon.create_player("Joel", :chute, :soco, :cura) == expected_response
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Joel", :chute, :soco, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game is started!"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Joel", :chute, :sock, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:voadora)
        end)

      assert messages =~ "Invalid move: voadora"
    end
  end
end
