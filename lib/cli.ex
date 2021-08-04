defmodule CLI do
  @commands %{
    "quit" => "Quits Tic Tac Toe"
  }

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

  def receive_command do
    IO.gets("> ")
    |> String.trim
    |> String.downcase
    |> execute_command
  end
  
  def execute_command(command) do
    case command do
      "quit" -> IO.puts("Good bye")
      _ ->
          IO.puts("Invalid command")
          print_help_msg()
          receive_command()
    end
  end
end
