defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    limit = :math.sqrt(number)
    |> trunc()

    prime_factors(number, limit, [])
  end

  @spec prime_factors(pos_integer(), pos_integer(), list()) :: list()
  defp prime_factors(1, _limit, result), do: Enum.reverse(result)
  defp prime_factors(number, limit, result) when number < 4 do
    nx = Stream.filter(2..number, &dividing?(number, &1))
    |> Enum.take(1)
    |> List.first(number)

    prime_factors(div(number, nx), limit, [nx | result])
  end

  defp prime_factors(number, limit, result) do
    nx = Stream.filter(2..limit, &dividing?(number, &1))
    |> Enum.take(1)
    |> List.first(number)

    prime_factors(div(number, nx), limit, [nx | result])
  end

  @spec dividing?(pos_integer(), pos_integer()) :: boolean()
  defp dividing?(number, number2), do: rem(number, number2) === 0
end
