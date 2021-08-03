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
      nil -> {:error, :invalid_location}
      :o -> {:error, :taken}
      :x -> {:error, :taken}
      :empty -> {:ok, %{board | square => player}}
    end
  end

  def check_progress(board) do
    mapped_board =
      board
      |> Enum.map(fn {square, value} -> {square.position, value} end)
      |> Map.new()

    cond do
      mapped_board |> Map.values() |> Enum.member?(:o) == false ||
      mapped_board |> Map.values() |> Enum.member?(:x) == false ->
        {:ok, board}
      # Rows
      # mapped_board[1] == :o && mapped_board[2] == :o && mapped_board[3] == :o -> {:ok, :winner_o}
      mapped_board |> Enum.map(fn {position, value} -> if position in 1..3, do: value end) |> Enum.filter(fn value -> value != nil end) == [:o,:o,:o] -> {:ok, :winner_o}
      mapped_board[4] == :o && mapped_board[5] == :o && mapped_board[6] == :o -> {:ok, :winner_o}
      mapped_board[7] == :o && mapped_board[8] == :o && mapped_board[9] == :o -> {:ok, :winner_o}
      mapped_board[1] == :x && mapped_board[2] == :x && mapped_board[3] == :x -> {:ok, :winner_x}
      # Col

      # Diagonal
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

  def three_in_a_row(mapped_board, positions, player) do
    mapped_board 
      |> Enum.map(fn {position, value} -> if position in positions, do: value end) 
      |> Enum.filter(fn value -> value != nil end) == [player, player, player] 
  end
end
