defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) do
    aliquot_sum =
      for x <- 1..trunc(:math.sqrt(number)),
      rem(number, x) == 0,
      into: [] do
        [x, div(number, x)]
      end
      |> List.flatten()
      |> Enum.dedup()
      |> Enum.sum()
      |> Kernel.-(number)

    cond do
      aliquot_sum === number -> {:ok, :perfect}
      aliquot_sum > number -> {:ok, :abundant}
      aliquot_sum < number -> {:ok, :deficient}
    end
  end
end
