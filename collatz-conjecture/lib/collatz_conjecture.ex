defmodule CollatzConjecture do
  defguardp is_even(value) when is_integer(value) and rem(value, 2) == 0 and value > 0
  defguardp is_odd(value) when is_integer(value) and rem(value, 2) == 1 and value > 0

  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(1), do: 0
  def calc(input) when is_even(input), do: 1 + calc(div(input, 2))
  def calc(input) when is_odd(input), do: 1 + calc(3 * input + 1)
end
