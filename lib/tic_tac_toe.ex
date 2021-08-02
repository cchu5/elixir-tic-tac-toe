defmodule TicTacToe do
  def new_board do
    for square <- [%Square{position: 1}], into: %{}, do: {square, :empty}
  end
end