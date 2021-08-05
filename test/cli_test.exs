defmodule CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest CLI

	describe "main tests: " do
		test "Player O wins" do
			io_output = capture_io([input: "start\n1\n4\n2\n5\n3", capture_prompt: false], fn -> CLI.main() end)
		
			assert String.contains?(io_output, "Player O wins! Thanks for playing!") == true	
		end

		test "Player X wins" do
			io_output = capture_io([input: "start\n1\n4\n2\n5\n9\n6", capture_prompt: false], fn -> CLI.main() end)
			
			assert String.contains?(io_output, "Player X wins! Thanks for playing!") == true
		end

		test "Game ends with a draw" do
			io_output = capture_io([input: "start\n1\n2\n3\n5\n4\n7\n6\n9\n8", capture_prompt: false], fn -> CLI.main() end)

			assert String.contains?(io_output, "It's a draw! Thanks for playing!")
		end
	end

  describe "print_help_msg tests: " do
    test "prints commands" do
      expected = """
      These are the following commands:
       quit - Quits Tic Tac Toe
       start - Begin a game of Tic Tac Toe
      """
      assert capture_io(fn ->
        CLI.print_help_msg()
      end) == expected
    end
  end

  describe "print_game_commands tests: " do
    test "prints game commands" do
      expected = """
      These are the following game commands:
       1..9 - Choose a position matching one of these numbers
      """
    
      assert capture_io(fn ->
        CLI.print_game_commands()
      end) == expected
    end
  end

  describe "receive_command tests: " do
    test "quit returns Good bye" do
      expected = capture_io([input: "quit", capture_prompt: false], fn -> CLI.receive_command() end)
				|> String.contains?("Good bye")
      
			assert expected == true
    end

		test "start returns Let's go" do
			expected = capture_io([input: "start\n1\n4\n2\n5\n3", capture_prompt: false], fn -> CLI.receive_command() end)
				|> String.contains?("Let's go")

			assert expected == true
		end
		
		test "random string returns Invalid command" do
			expected = capture_io([input: "random\nquit", capture_prompt: false], fn -> CLI.receive_command() end)
				|> String.contains?("Invalid command")
			
			assert expected == true
		end
  end
end
