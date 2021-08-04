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
end
