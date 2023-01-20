defmodule ExMon.Game.StatusTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Status, as: GameStatus

  setup_all do
    info = %{
      computer: %{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Browser Jr"
      },
      player: %{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Mario"
      },
      turn: :player
    }

    {:ok, %{info: info}}
  end

  describe "print_round_message/1" do
    test "when the game started prints the round message", %{info: info} do
      IO.puts("ADAD")

      assert capture_io(fn ->
               GameStatus.print_round_message(Map.put(info, :status, :started))
             end) =~ "The game is started!"
    end

    test "when the game is in progress prints the round message", %{info: info} do
      assert capture_io(fn ->
               GameStatus.print_round_message(Map.put(info, :status, :continue))
             end) =~ "It's player turn."
    end

    test "when the game is in game_over prints the round message", %{info: info} do
      assert capture_io(fn ->
               GameStatus.print_round_message(Map.put(info, :status, :game_over))
             end) =~ "The game is over."
    end
  end

  describe "print_wrong_move_message/1" do
    test "when the move is invalid prints the wrong move message" do
      assert capture_io(fn ->
               GameStatus.print_wrong_move_message("invalid move")
             end) =~ "Invalid move: invalid move."
    end
  end

  describe "print_move_message/3" do
    test "when the player attacks the computer prints the move message" do
      assert capture_io(fn ->
               GameStatus.print_move_message(:computer, :attack, 10)
             end) =~ "The Player attacked the computer dealing: 10 damage."
    end

    test "when the computer attacks the player prints the move message" do
      assert capture_io(fn ->
               GameStatus.print_move_message(:player, :attack, 10)
             end) =~ "The Computer attacked the player dealing: 10 damage."
    end

    test "when the player heals itself prints the move message" do
      assert capture_io(fn ->
               GameStatus.print_move_message(:player, :heal, 100)
             end) =~ "The player healed itself to 100 life points."
    end
  end
end
