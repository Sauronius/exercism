defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found
  def search(numbers, key) do
    search_help(numbers, key, 0, tuple_size(numbers) - 1)
  end

  @spec search_help(tuple, integer, integer, integer) :: {:ok, integer} | :not_found
  defp search_help(numbers, key, first, last) do
    position = first
    |> Kernel.+(last)
    |> Kernel./(2)
    |> Kernel.round()

    value = elem(numbers, position)
    cond do
      value == key -> {:ok, position}
      value != key and first == last -> :not_found
      value < key -> search_help(numbers, key, position + 1, last)
      value > key -> search_help(numbers, key, first, position - 1)
    end
  end
end
