defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    one_factor(limit, factors, [0])
  end

  @spec one_factor(non_neg_integer, [non_neg_integer], [non_neg_integer]) :: non_neg_integer
  defp one_factor(_limit, [], result_list) do
    result_list
    |> Stream.uniq()
    |> Enum.sum()
  end

  defp one_factor(limit, [h | t], result_list) do
    if limit > h and h != 0 do
      list1 =
        for a <- h..limit-1,
          rem(a, h) == 0 do
           a
          end

      one_factor(limit, t, Enum.concat([result_list, list1]))
    else
      one_factor(limit, t, result_list)
    end
  end
end
