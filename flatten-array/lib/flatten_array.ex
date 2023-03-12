defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    flatten_ht(list, [])
  end

  @spec flatten_ht(list(), list()) :: list()
  defp flatten_ht([], result), do: Enum.reverse(result)

  defp flatten_ht([h | t], result) do
  cond do
    is_list(h) -> r2 = flatten_ht(h, result)
                    |> Enum.reverse()

                  flatten_ht(t, r2)
    h != :nil -> flatten_ht(t, [h | result])
    :true -> flatten_ht(t, result)
  end
  end
end
