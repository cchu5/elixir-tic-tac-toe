defmodule Square do
  # @enforce: Any new square that's made must have row and col
  @enforce_keys [:position]
  # This is a structure with row and col keys
  defstruct [:position]

  # Square.new to create a new square struct
  def new(position) when position in 1..9 do
    {:ok, %Square{position: position}}
  end

  # Catches any squares that doesnt match line 8
  def new(_position), do: {:error, :invalid_square}
end
