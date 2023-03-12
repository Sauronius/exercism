defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    Enum.map_join([3, 5, 7], &raindrop_sound(number, &1))
    |> result_string(number)
  end

  @spec raindrop_sound(pos_integer(), pos_integer()) :: String.t()
  defp raindrop_sound(pos_integer, 3) when rem(pos_integer, 3) == 0, do: "Pling"
  defp raindrop_sound(pos_integer, 5) when rem(pos_integer, 5) == 0, do: "Plang"
  defp raindrop_sound(pos_integer, 7) when rem(pos_integer, 7) == 0, do: "Plong"
  defp raindrop_sound(_pos_integer, _divider), do: ""

  @spec result_string(String.t(), pos_integer()) :: String.t()
  defp result_string(result, pos_integer) do
    if result == "" do
      Integer.to_string(pos_integer, 10)
    else
      result
    end
  end
end
