defmodule Scrabble do
  @scrabble_points [{1, ["a", "e", "i", "o", "u", "l", "n", "r", "s", "t"]},
                    {2, ["d", "g"]}, {3, ["b", "c", "m", "p"]}, {4, ["f", "h", "v", "w", "y"]},
                    {5, ["k"]}, {8, ["j", "x"]}, {10, ["q", "z"]}]
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase()
    |> String.split("", trim: true)
    |> Enum.frequencies()
    |> Enum.map(&map_value/1)
    |> Enum.sum()
  end

  @spec map_value({String.t(), non_neg_integer()}) :: non_neg_integer()
  defp map_value({x, y}) do
    @scrabble_points
    |> Enum.find({0, "zero"}, fn {_a, b} -> Enum.any?(b, fn c -> c == x end) end)
    |> elem(0)
    |> Kernel.*(y)
  end
end
