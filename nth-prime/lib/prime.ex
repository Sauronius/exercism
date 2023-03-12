defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise "No 0th prime"

  def nth(count), do: sieve(Enum.to_list(2..count*15)) |> Enum.at(count-1)

  defp sieve([h | t]), do: [h | sieve(t -- multiples_of(h, t))]

  defp sieve([]), do: []

  defp multiples_of(h, t), do: for(n <- 1..length(t), do: h * n)

end
