defmodule TicTacToe do

  def check_player(player) do
    case player do
      :x -> {:ok, player}
      :o -> {:ok, player}
      _ -> {:error, :invalid_player}
    end
  end

  def choose_square(board, square, player) do
    {:ok, %{board | square => player}}
  end
  
  def new_board do
    squares = for position <- 1..9, into: MapSet.new(), do: %Square{position: position}
    for square <- squares, into: %{}, do: {square, :empty}
  end
end