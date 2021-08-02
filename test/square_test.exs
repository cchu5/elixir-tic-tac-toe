defmodule SquareTest do
  use ExUnit.Case
  doctest Square

  test "create a square" do
    assert function_exported?(Square, :new, 1) == true
  end
end
