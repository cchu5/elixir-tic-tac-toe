defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  describe "tests for board" do
    test "create new board" do
      assert function_exported?(TicTacToe, :new_board, 0) == true

      board = TicTacToe.new_board()
      assert board |> is_map == true

      expected_square = %Square{position: 1}
      assert board |> Enum.fetch(0) == {:ok, {expected_square, :empty}}
    end

    test "board should have 9 squares" do
      assert TicTacToe.new_board() |> Map.keys |> length > 0
      assert TicTacToe.new_board() |> Map.keys |> Enum.count == 9
    end
  end

  describe "tests for players" do
    test "player should be :o or :x" do
      assert function_exported?(TicTacToe, :check_player, 1) == true
      assert TicTacToe.check_player(:o) == {:ok, :o}
      assert TicTacToe.check_player(:x) == {:ok, :x}
      assert TicTacToe.check_player(:z) == {:error, :invalid_player}
    end
  end

  describe "tests for actions" do
    test "choose an empty square" do
      assert function_exported?(TicTacToe, :choose_square, 3) == true

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
end
