defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []), do: :equal
  def compare([], _b), do: :sublist
  def compare(_a, []), do: :superlist
  def compare(a, b) do
    compare_ext(a, b, Enum.count(a), Enum.count(b))
  end

  defp compare_ext(a, b, count_a, count_b) when count_a > count_b do
    start_elem = List.first(b, [])
    to_cut = Enum.find_index(a, fn x -> x == start_elem end)
    if to_cut == :nil do
      :unequal
    else
      eq_check = output_ext(a, count_a, b, count_b, start_elem)
      if eq_check == :true do
        :superlist
      else
        :unequal
      end
    end
  end

  defp compare_ext(a, b, count_a, count_b) when count_a < count_b do
    start_elem = List.first(a)
    to_cut = Enum.find_index(b, fn x -> x == start_elem end)
    if to_cut == :nil do
      :unequal
    else
      eq_check = output_ext(b, count_b, a, count_a, start_elem)
      if eq_check == :true do
        :sublist
      else
        :unequal
      end
    end
  end

  defp compare_ext(a, b, count_a, count_b) when count_a == count_b do
    if is_equal?(a, b) do
      :equal
    else
      :unequal
    end
  end

  defp is_equal?(list_a, list_b) do
    List.starts_with?(list_a, list_b)
  end

  defp output_ext(list, count_range, list2, count_list2, start_elem) do
    to_cut = Enum.find_index(list, fn x -> x == start_elem end)
    if to_cut == :nil do
      :false
    else
      truth_test =
      list
      |> Enum.slice(to_cut..to_cut + count_range)
      |> is_equal?(list2)

      cond do
      truth_test == :true -> :true
      truth_test == :false and Enum.count(list) > count_list2 -> output_ext(tl(list), count_range, list2, count_list2, start_elem)
      truth_test == :false and Enum.count(list) <= count_list2 -> :false
      end
    end
  end
end
