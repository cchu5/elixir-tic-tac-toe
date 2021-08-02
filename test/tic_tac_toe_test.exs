defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "create new board" do
    assert function_exported?(TicTacToe, :new_board, 0) == true
    assert TicTacToe.new_board() |> is_map == true

    board = TicTacToe.new_board()
    expected_square = %Square{position: 1}
    assert board |> Enum.fetch(0) == {:ok, {expected_square, :empty}}
  end

  test "board should have 9 squares" do
    assert TicTacToe.new_board() |> Map.keys |> length > 0
    assert TicTacToe.new_board() |> Map.keys |> Enum.count == 9
  end
end
