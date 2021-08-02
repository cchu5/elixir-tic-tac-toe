defmodule TicTacToe do
  # Module Attribute for Players
  @players {:x, :o}

  def check_player(player) do
    # Make sure player attribute is either :o or :x
    case player do
      :x -> {:ok, player}
      :o -> {:ok, player}
      _ -> {:error, :invalid_player}
    end
  end

  def choose_square(board, square, player) do
    # For the board square, check if it:
    # 1. Exists
    # 2. Is not taken by :x or :o
    # If it's not taken, you can return
    case board[square] do
      nil -> {:error, :invalid_location}
      :x -> {:error, :taken}
      :o -> {:error, :taken}
      :empty -> {:ok, %{board | square => player}}
    end
  end

  def play_at(board, position, player) do
    # Below is the response from the piped output
    # Check if player is valid
    with {:ok, valid_player} <- check_player(player),
         # Check if Square is valid
         {:ok, square} <- Square.new(position),
         # Check if square chosen is valid
         {:ok, new_board} <- choose_square(board, square, valid_player),
         # Respond with new_board, else error
         do: new_board
  end

  def new_board do
    # For every square
    # Insert map of k: Square and v: :empty into an empty map
    for square <- squares(), into: %{}, do: {square, :empty}
  end

  def squares do
    # For every column and row from range of 1..3, 
    # insert Square into a new MapSet (No duplicates, unique)
    for position <- 1..9, into: MapSet.new(), do: %Square{position: position}
  end
end
