defmodule RomanNumerals do
  @zero %{0 => "", 1 => "I", 2 => "II", 3 => "III", 4 => "IV", 5 => "V", 6 => "VI", 7 => "VII", 8 => "VIII", 9 => "IX"}
  @one %{0 => "", 1 => "X", 2 => "XX", 3 => "XXX", 4 => "XL", 5 => "L", 6 => "LX", 7 => "LXX", 8 => "LXXX", 9 => "XC"}
  @two %{0 => "", 1 => "C", 2 => "CC", 3 => "CCC", 4 => "CD", 5 => "D", 6 => "DC", 7 => "DCC", 8 => "DCCC", 9 => "CM"}
  @three %{0 => "", 1 => "M", 2 => "MM", 3 => "MMM"}
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> to_digits([])
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(&to_roman_digit/1)
    |> Enum.reverse()
    |> List.to_string()
  end

  @spec to_digits(pos_integer(), list()) :: [integer()]
  defp to_digits(number, digits) do
    if number > 9 do
      to_digits(div(number, 10), [rem(number, 10) | digits])
    else
      [number | digits]
    end
  end

  @spec to_roman_digit({integer(), integer()}) :: String.t()
  defp to_roman_digit({digit, index}) do
    case index do
      0 -> @zero[digit]
      1 -> @one[digit]
      2 -> @two[digit]
      3 -> @three[digit]
    end
  end
end
