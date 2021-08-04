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
      mapped_board |> made_a_move(:o) == false ||
      mapped_board |> made_a_move(:x) == false ->
        {:ok, board}
      # Rows
      three_in_a_row(mapped_board, [1,2,3], :o) -> {:ok, :winner_o}
      three_in_a_row(mapped_board, [4,5,6], :o) -> {:ok, :winner_o}
      three_in_a_row(mapped_board, [7,8,9], :o) -> {:ok, :winner_o}
      three_in_a_row(mapped_board, [1,2,3], :x) -> {:ok, :winner_x}
      three_in_a_row(mapped_board, [4,5,6], :x) -> {:ok, :winner_x}
      three_in_a_row(mapped_board, [7,8,9], :x) -> {:ok, :winner_x}
      # Columns
      three_in_a_row(mapped_board, [1,4,7], :o) -> {:ok, :winner_o}
      three_in_a_row(mapped_board, [2,5,8], :o) -> {:ok, :winner_o}
      three_in_a_row(mapped_board, [3,6,9], :o) -> {:ok, :winner_o}
      three_in_a_row(mapped_board, [1,4,7], :x) -> {:ok, :winner_x}
      three_in_a_row(mapped_board, [2,5,8], :x) -> {:ok, :winner_x}
      three_in_a_row(mapped_board, [3,6,9], :x) -> {:ok, :winner_x}
      # Diagonal
      three_in_a_row(mapped_board, [1,5,9], :o) -> {:ok, :winner_o}
      three_in_a_row(mapped_board, [3,5,7], :o) -> {:ok, :winner_o}
      three_in_a_row(mapped_board, [1,5,9], :x) -> {:ok, :winner_x}
      three_in_a_row(mapped_board, [3,5,7], :x) -> {:ok, :winner_x}
      # Still in progress
      mapped_board -> {:ok, board}
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

  def all_spaces_taken(mapped_board) do
    mapped_board
      |> Enum.filter(fn {position, value} -> value == :empty end)
      |> length <= 1
  end

  def three_in_a_row(mapped_board, positions, player) do
    mapped_board 
      |> Enum.map(fn {position, value} -> if position in positions, do: value end) 
      |> Enum.filter(fn value -> value != nil end) == [player, player, player] 
  end

  def made_a_move(mapped_board, player) do
    mapped_board
      |> Map.values
      |> Enum.member?(player)
  end
end
