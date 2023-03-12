defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.split("", trim: true)
    |> Enum.chunk_while([], fn element, acc ->
      if List.first(acc) == element or acc == [] do
        {:cont, [element | acc]}
      else
        {:cont, acc, [element]}
      end
    end, fn
      [] -> {:cont, []}
      acc -> {:cont, acc, []}
    end)
    |> Enum.map(fn x -> if Enum.count(x) > 1 do
        [Integer.to_string(Enum.count(x), 10), List.first(x)]
      else
        x
      end end)
    |> List.flatten()
    |> List.to_string()
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.split("", trim: true)
    |> Enum.map(fn <<x>> -> if x in ?0..?9 do
      String.to_integer(<<x>>, 10)
    else
      <<x>>
    end end)
    |> Enum.chunk_while([], fn element, acc ->
      if List.first(acc) in 0..9 and element in 0..9 or acc == [] do
        {:cont, [element | acc]}
      else
        {:cont, Enum.reverse(acc), [element]}
      end
    end, fn
      [] -> {:cont, []}
      acc -> {:cont, acc, []}
    end)
    |> Enum.map(fn x -> if Enum.any?(x, &is_integer/1) do
        to_one_number(x)
      else
        x
      end end)
    |> List.flatten()
    |> unpack("x", [])
    |> Enum.reverse()
    |> Enum.filter(fn x -> !is_integer(x) end)
    |> List.to_string()
  end

  @spec to_one_number(list()) :: non_neg_integer()
  defp to_one_number(list) do
    list
    |> Enum.reverse
    |> Enum.with_index()
    |> Enum.map(fn {a, b} -> a * 10 ** b end)
    |> Enum.sum()
  end

  @spec unpack(list(), any(), list()) :: list()
  defp unpack([], _elem, result), do: result
  defp unpack([h | t], elem, result) do
    if is_integer(elem) do
      unpack(t, h, [List.duplicate(h, elem) | result])
    else
      unpack(t, h, [h | result])
    end
  end
end
