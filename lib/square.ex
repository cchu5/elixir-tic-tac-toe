defmodule Square do
  @enforce_keys [:position]

  defstruct [:position]

  def new(position) when position in 1..9 do
    {:ok, %Square{position: position}}
  end

  def new(_position), do: {:error, :invalid_square}
end
