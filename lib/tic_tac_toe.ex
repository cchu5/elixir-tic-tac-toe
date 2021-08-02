defmodule TicTacToe do

  def check_player(player) do
    "player #{player}"
  end
  
  def new_board do
    squares = for position <- 1..9, into: MapSet.new(), do: %Square{position: position}
    for square <- squares, into: %{}, do: {square, :empty}
  end
end