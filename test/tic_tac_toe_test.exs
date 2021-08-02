defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "create new board" do
    assert TicTacToe.new_board() |> is_map == true
  end
end
