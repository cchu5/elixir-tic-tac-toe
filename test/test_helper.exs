defmodule TestHelper do
  def create_populated_board(positions_and_players) do  
    mapped_tuples = Enum.into(positions_and_players, %{})
    squares = for position <- 1..9, into: MapSet.new(), do: %Square{position: position}
    squares 
      |> Enum.map(fn square -> if mapped_tuples[square.position], do: {square, mapped_tuples[square.position]}, else: {square, :empty} end)
      |> Map.new
  end
end

ExUnit.start()
