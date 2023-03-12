defmodule Allergies do
  @allergens %{0 => "eggs", 1 => "peanuts", 2 => "shellfish", 3 => "strawberries",
               4 => "tomatoes", 5 => "chocolate", 6 => "pollen", 7 => "cats"}
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    flags
    |> rem(256)
    |> Integer.digits(2)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {x, index} -> if x === 0 do "" else Map.get(@allergens, index) end end)
    |> Enum.reject(fn x -> x == "" end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    flags
    |> list()
    |> Enum.any?(&String.equivalent?(&1, item))
  end
end
