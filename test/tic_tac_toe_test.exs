defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "create new board" do
    assert function_exported?(TicTacToe, :new_board, 0) == true
    assert TicTacToe.new_board() |> is_map == true
    assert TicTacToe.new_board() |> Map.keys |> length > 0
  end
end
