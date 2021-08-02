defmodule TicTacToe do

  def check_player(player) do
    case player do
      :x -> {:ok, player}
      :o -> {:ok, player}
      _ -> {:error, :invalid_player}
    end
  end

  def choose_square(board, square, player) do
    case board[square] do
      :nil -> {:error, :invalid_location}
      :o -> {:error, :taken}
      :x -> {:error, :taken}
      :empty -> {:ok, %{board | square => player}}
    end
  end

  def play_at(board, position, player) do
    with {:ok, valid_player} <- check_player(player),
         {:ok, square} <- Square.new(position),
         {:ok, new_board} <- choose_square(board, square, valid_player),
         do: new_board    
  end
  
  def new_board do
    squares = for position <- 1..9, into: MapSet.new(), do: %Square{position: position}
    for square <- squares, into: %{}, do: {square, :empty}
  end
end
