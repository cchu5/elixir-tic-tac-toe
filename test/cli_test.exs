defmodule CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest CLI
    
  test "CLI prints hello" do
    assert capture_io(fn ->
      CLI.main()
    end) == "Hello\n"
  end
end
