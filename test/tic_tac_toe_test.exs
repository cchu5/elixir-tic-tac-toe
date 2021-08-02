defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "create new board" do
    assert TicTacToe.new_board() |> Map.values() |> length == 9
  end

  test "generate 3x3 squares" do
    assert TicTacToe.squares() |> MapSet.size() == 9
  end
end
