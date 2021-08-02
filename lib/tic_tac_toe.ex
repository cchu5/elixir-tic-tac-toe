defmodule TicTacToe do
  def new_board do
   for square <- 1..9, into: %{}, do: {square, :empty}
  end
end