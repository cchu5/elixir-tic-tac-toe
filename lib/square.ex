defmodule Square do
  # TODO: Should this be a Struct or just {1 => :empty} ?
  @enforce_keys [:position]

  defstruct [:position]

  def new(position) when position in 1..9 do
    {:ok, %Square{position: position}}
  end

  def new(_position), do: {:error, :invalid_square}
end
