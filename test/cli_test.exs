defmodule CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest CLI
    
  test "CLI main prints msg" do
    expected = """
    Welcome to Tic Tac Toe!
    These are the following commands:
     quit - Quits Tic Tac Toe
    """ 
    assert capture_io(fn ->
      CLI.main()
    end) == expected
  end

  describe "print_help_msg tests: " do
    test "prints commands" do
      expected = """
      These are the following commands:
       quit - Quits Tic Tac Toe
      """
      assert capture_io(fn ->
        CLI.print_help_msg()
      end) == expected
    end
  end

  describe "receive_command tests: " do
    test "returns command" do
      capture_io([input: "quit", capture_prompt: false], fn ->  
        command = CLI.receive_command()
        send(self(), {:command, command})
      end)
      assert_received {:command, "quit"}
    end
  end
end
