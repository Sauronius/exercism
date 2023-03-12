defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
      custom_rows(1, [], num)
  end

  @spec custom_rows(non_neg_integer(), list(), non_neg_integer()) :: [[integer()]]
  defp custom_rows(_, prev, 0), do: Enum.reverse(prev)
  defp custom_rows(1, [], left), do: custom_rows(2, [[1]], left - 1)
  defp custom_rows(num, [prev | _rest] = overall, left) do
    list1 =
      prev
      |> Enum.slice(0..div(num - 1, 2))

    list2 =
      list1
      |> List.insert_at(0, 0)
      |> Enum.zip_with(list1, fn x, y -> x + y end)

    list3 =
      list2
      |> Enum.reverse()

      if rem(num, 2) == 0 do
        custom_rows(num + 1, [Enum.concat([list2, list3]) | overall], left - 1)
      else
        custom_rows(num + 1, [Enum.concat([list2, List.delete_at(list3, 0)]) | overall], left - 1)
      end
  end
end
