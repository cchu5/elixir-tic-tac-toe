defmodule CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest CLI

#  test "CLI main prints msg upon quit" do
#    expected = """
#    Welcome to Tic Tac Toe!
#    These are the following commands:
#     quit - Quits Tic Tac Toe
#    Good bye
#    """ 
#    assert capture_io([input: "quit", capture_prompt: false], fn ->
#      CLI.main()
#    end) == expected
#  end

  describe "print_help_msg tests: " do
    test "prints commands" do
      expected = """
      These are the following commands:
       start - Begin a game of Tic Tac Toe
       quit - Quits Tic Tac Toe
      """
      assert capture_io(fn ->
        CLI.print_help_msg()
      end) == expected
    end
  end

  describe "receive_command tests: " do
    test "quit returns Good bye" do
      assert capture_io([input: "quit", capture_prompt: false], fn ->  
        CLI.receive_command()
      end) == "Good bye\n"
    end
  end
end
