defmodule TicTacToeTest do
  import TestHelper
  use ExUnit.Case
  doctest TicTacToe

  describe "new_board tests: " do
    test "new_board exists" do
      assert function_exported?(TicTacToe, :new_board, 0) == true
    end

    test "create new board" do
      board = TicTacToe.new_board()
      assert board |> is_map == true

      expected_square = %Square{position: 1}
      assert board |> Enum.fetch(0) == {:ok, {expected_square, :empty}}
    end

    test "board should have 9 squares" do
      assert TicTacToe.new_board() |> Map.keys() |> length > 0
      assert TicTacToe.new_board() |> Map.keys() |> Enum.count() == 9
    end
  end

  describe "check_player tests: " do
    test "check_player exists" do
      assert function_exported?(TicTacToe, :check_player, 1) == true
    end

    test "player should be :o or :x" do
      assert TicTacToe.check_player(:o) == {:ok, :o}
      assert TicTacToe.check_player(:x) == {:ok, :x}
      assert TicTacToe.check_player(:z) == {:error, :invalid_player}
    end
  end

  describe "choose_square tests: " do
    test "choose_square exists" do
      assert function_exported?(TicTacToe, :choose_square, 3) == true
    end

    test "choose an empty square" do
      board = TicTacToe.new_board()
      square = %Square{position: 1}

      board = TicTacToe.choose_square(board, square, :o)

      assert {:ok, result} = board
      assert result |> Enum.fetch(0) == {:ok, {square, :o}}
    end

    test "choose a square that's been chosen" do
      board = TicTacToe.new_board()
      square = %Square{position: 1}
      {:ok, board} = TicTacToe.choose_square(board, square, :o)
      result = TicTacToe.choose_square(board, square, :x)

      assert {:error, :taken} = result
    end

    test "choose a nonexistent square" do
      board = TicTacToe.new_board()
      result = TicTacToe.choose_square(board, "", :o)

      assert {:error, :invalid_location} = result
    end
  end

  describe "play_at tests: " do
    test "play_at exists" do
      assert function_exported?(TicTacToe, :play_at, 3) == true
    end

    test "play_at returns a new_board" do
      board = TicTacToe.new_board()

      {:ok, expected_board} = TicTacToe.choose_square(board, %Square{position: 1}, :o)
      new_board = TicTacToe.play_at(board, 1, :o)

      assert new_board == expected_board
    end
  end

  describe "check_progress tests: " do
    test "check_progress exists" do
      assert function_exported?(TicTacToe, :check_progress, 1) == true
    end

    test "check_progress returns a new_board if there are no moves yet or only one move" do
      board = TicTacToe.new_board()
      {:ok, expected_board} = TicTacToe.choose_square(board, %Square{position: 1}, :o)
      {:ok, new_board} = TicTacToe.check_progress(expected_board)

      assert new_board == expected_board
    end

    test "check_progress returns the winner if a player wins" do
      board = TicTacToe.new_board() |> TicTacToe.play_at(1, :o) |> TicTacToe.play_at(4, :x) |> TicTacToe.play_at(2, :o) |> TicTacToe.play_at(5, :x) |> TicTacToe.play_at(3, :o)
      
      assert {:ok, :winner_o} = TicTacToe.check_progress(board)
    end

    test "check_progress returns draw if no one wins and no more moves" do 
      
    end
  end

  describe "three_in_a_row tests: " do
    test "three_in_a_row exists" do
      assert function_exported?(TicTacToe, :three_in_a_row, 3) == true
    end

    test "three_in_a_row returns true for horizontal win" do 
      mapped_board_for_o_win = 
        create_populated_board([{1,:o}, {2,:o}, {3,:o}, {4,:x}, {5,:x}]) 
        |> Enum.map(fn {square, value} -> {square.position, value} end) |> Map.new()
      mapped_board_for_x_win = 
        create_populated_board([{1,:o}, {2,:o}, {4,:x}, {5,:x}, {6,:x}]) 
        |> Enum.map(fn {square, value} -> {square.position, value} end) |> Map.new() 
      positions_o = [1, 2, 3]
      positions_x = [4, 5, 6]
 
      assert TicTacToe.three_in_a_row(mapped_board_for_o_win, positions_o, :o) == true
      assert TicTacToe.three_in_a_row(mapped_board_for_x_win, positions_x, :x) == true
    end
  end
end
