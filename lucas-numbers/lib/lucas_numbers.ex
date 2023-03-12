defmodule LucasNumbers do
  def generate(1), do: [2]
  def generate(2), do: [2, 1]
  def generate(count) when is_integer(count) and count > 0 do
    {2, 1}
    |> Stream.iterate(fn {a, b} -> {b, a + b} end)
    |> Enum.take(count)
    |> Enum.map(&(elem(&1, 0)))
  end
  def generate(_), do: raise(ArgumentError, "count must be specified as an integer >= 1")
end
