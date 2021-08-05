defmodule SquareTest do
  use ExUnit.Case
  doctest Square

  test "create a square" do
    assert function_exported?(Square, :new, 1) == true
  end

  test "square positions should only be 1..9" do
    assert Square.new(1) == {:ok, %Square{position: 1}}
    assert Square.new(9) == {:ok, %Square{position: 9}}
    assert Square.new(10) == {:error, :invalid_square}
  end
end
