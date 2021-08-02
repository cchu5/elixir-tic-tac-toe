defmodule Square do
  @enforce_keys [:position]

  defstruct [:position]

  def new(position) do
    {:ok, %Square{position: position}}
  end
end