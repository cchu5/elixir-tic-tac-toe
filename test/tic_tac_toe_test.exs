defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  test "create new board" do
    assert function_exported?(TicTacToe, :new_board, 0) == true
  end
end
