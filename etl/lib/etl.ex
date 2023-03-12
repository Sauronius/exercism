defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Map.to_list()
    |> Enum.map(fn {k, v} -> new_format(v, k) end)
    |> Enum.concat()
    |> Enum.sort()
    |> Enum.into(%{})
  end
  @spec new_format(list(), number()) :: map
  def new_format(list, value) do
    list
    |> Map.new(fn x -> {String.downcase(x), value} end)
  end
end
