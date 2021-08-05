defmodule CLI do
	@commands [
		{:start, "Begin a game of Tic Tac Toe"},
		{:quit, "Quits Tic Tac Toe"}
	]

	@game_commands [
		{"1..9", "Choose a position matching one of these numbers"}
	]

  def main() do
    IO.puts("Welcome to Tic Tac Toe!")
    print_help_msg()
    receive_command()
  end

  def print_help_msg do
    IO.puts("These are the following commands:")
    @commands
    |> Enum.map(fn {command, description} -> IO.puts(" #{command} - #{description}") end)
  end

  def print_game_commands do
    IO.puts("These are the following game commands:")
    @game_commands
    |> Enum.map(fn {command, description} -> IO.puts(" #{command} - #{description}") end)
  end

  def receive_command do
    IO.gets("> ")
    |> String.trim
    |> String.downcase
    |> execute_command
  end
  
  def receive_command(board, player) do
    IO.gets("> ")
    |> String.trim
    |> String.downcase
    |> execute_command(board, player)
  end

  def execute_command(command) do
    case command do
      "start" -> 
          IO.puts("Let's go")
          print_game_commands()
          board = TicTacToe.new_board()
          print_board(board)
          receive_command(board, :o)
      "quit" -> IO.puts("Good bye")
      _ ->
          IO.puts("Invalid command")
          print_help_msg()
          receive_command()
    end
  end
  
  def execute_command(command, board, player) do
    case command do
      "1" -> 
          TicTacToe.play_at(board, 1, player)
          |> tic_tac_toe_progress(player)
      "2" ->
          TicTacToe.play_at(board, 2, player)
          |> tic_tac_toe_progress(player)
      "3" ->
          TicTacToe.play_at(board, 3, player)
          |> tic_tac_toe_progress(player)
      "4" ->
          TicTacToe.play_at(board, 4, player)
          |> tic_tac_toe_progress(player)
      "5" ->
          TicTacToe.play_at(board, 5, player)
          |> tic_tac_toe_progress(player)
      "6" ->
          TicTacToe.play_at(board, 6, player)
          |> tic_tac_toe_progress(player)
      "7" ->
          TicTacToe.play_at(board, 7, player)
          |> tic_tac_toe_progress(player)
      "8" ->
          TicTacToe.play_at(board, 8, player)
          |> tic_tac_toe_progress(player)
      "9" -> 
          TicTacToe.play_at(board, 9, player)
          |> tic_tac_toe_progress(player)
      _ ->
          IO.puts("Invalid move")
          print_game_commands()
          print_board(board)
          receive_command(board, player)
    end 
  end

  def tic_tac_toe_progress(result, player) do
    {_, current_board, _} = result
    print_board(current_board)

    case result do
      {_, _, :winner_o} -> 
        IO.puts("Player O wins! Thanks for playing!") 
      {_, _, :winner_x} ->
        IO.puts("Player X wins! Thanks for playing!")
      {_, _, :draw} -> 
        IO.puts("It's a draw! Thanks for playing!")
      {_, board, :continue} -> 
        next_player = if player == :x, do: :o, else: :x
        IO.puts("Player #{next_player}, your move:")
        receive_command(board, next_player)
    end
  end
  
  def print_board(board) do
    map_positions_to_string = fn {square, value} ->
      if square.position in [3,6,9] do
        if value != :empty do
          " #{value} \n"
        else
          " #{square.position} \n"
        end
      else
        if value != :empty do
          " #{value} |"
        else
          " #{square.position} |"
        end
      end
    end
 
    visual_board =
      board
      |> Enum.map(map_positions_to_string)
      |> Enum.join("")

    IO.puts(visual_board)
  end
end
