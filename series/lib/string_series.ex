defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    slices_count = String.length(s) - size + 1
    result_list(s, size, slices_count, [])
  end

  @spec result_list(String.t(), integer(), integer(), [String.t()]) :: [String.t()]
  defp result_list(_string, size, slices_count, result) when slices_count <= 0 or size <= 0, do: Enum.reverse(result)

  defp result_list(string, size, slices_count, result) when slices_count > 0 do
    offset = count_offset(String.slice(string, 0..size - 1), size, 0)
    <<head::binary-size(offset), _rest::binary>> = string
    <<_first::binary-size(1), tail::binary>> = string
    result_list(tail, size, slices_count - 1, [head | result])
  end

  @spec count_offset(String.t(), integer(), integer()) :: integer()
  defp count_offset(_string, size, byte_size) when size == 0, do: byte_size

  defp count_offset(string, size, byte_size) when size > 0 do
    nbs =
      string
    |> String.next_grapheme()
    |> elem(0)
    |> byte_size()
    |> Kernel.+(byte_size)

    count_offset(String.slice(string, 1..size), size - 1, nbs)
  end
end
