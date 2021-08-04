defmodule CLI do
  @commands %{
    "quit" => "Quits Tic Tac Toe"
  }

  def main() do
    IO.puts("Welcome to Tic Tac Toe!")
    print_help_msg()
  end

  defp print_help_msg do
    IO.puts("These are the following commands:")
    @commands
    |> Enum.map(fn {command, description} -> IO.puts(" #{command} - #{description}") end)
  end
end
