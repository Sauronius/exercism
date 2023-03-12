defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  defguardp non_positive_size(a, b, c) when a <= 0 or b <= 0 or c <= 0
  defguardp wrong_sizes(a, b, c) when a + b < c or b + c < a or a + c < b
  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}

  def kind(a, b, c) when non_positive_size(a, b, c), do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) when wrong_sizes(a, b, c), do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c) do
    cond do
      a == b and b == c -> {:ok, :equilateral}
      a == b or a == c or b == c -> {:ok, :isosceles}
      :true -> {:ok, :scalene}
    end
  end
end
