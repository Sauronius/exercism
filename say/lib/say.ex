defmodule Say do
  defguardp is_out_of_range(a) when a < 0 or a > 999_999_999_999
  @doc """
  Translate a positive integer into English.
  """
  @names %{1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five",
           6 => "six", 7 => "seven", 8 => "eight", 9 => "nine"}

  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when is_out_of_range(number) do
    {:error, "number is out of range"}
  end

  def in_english(0) do
    {:ok, "zero"}
  end

  def in_english(number) do
    {:ok, String.trim(translate_to_english(number, "", 9))}
  end

  defp translate_to_english(number, prev, power_of_ten) when power_of_ten >= 0 do
    floor_div = Integer.floor_div(number, 10 ** power_of_ten)
    remainder = rem(number, 10 ** power_of_ten)
    cond do
      power_of_ten == 9 && floor_div != 0 -> translate_to_english(remainder, prev <> hundreds_in_english(floor_div) <> " billion ", power_of_ten - 3)
      power_of_ten == 9 && floor_div == 0 -> translate_to_english(remainder, prev, power_of_ten - 3)
      power_of_ten == 6 && floor_div != 0 -> translate_to_english(remainder, prev <> hundreds_in_english(floor_div) <> " million ", power_of_ten - 3)
      power_of_ten == 6 && floor_div == 0 -> translate_to_english(remainder, prev, power_of_ten - 3)
      power_of_ten == 3 && floor_div != 0 -> translate_to_english(remainder, prev <> hundreds_in_english(floor_div) <> " thousand ", power_of_ten - 3)
      power_of_ten == 3 && floor_div == 0 -> translate_to_english(remainder, prev, power_of_ten - 3)
      true -> prev <> hundreds_in_english(floor_div)
    end
  end

  @spec hundreds_in_english(integer()) :: String.t()
  defp hundreds_in_english(number) do
    h = div(number, 100)
    d = div(rem(number, 100), 10)
    u = rem(number, 10)

    hundreds(h) <> rest(d, u)
  end

  @spec hundreds(integer()) :: String.t()
  defp hundreds(number) do
    case number do
      0 -> ""
      _ -> Map.get(@names, number) <> " hundred "
    end
  end

  @spec rest(integer(), integer()) :: String.t()
  defp rest(number, number2) do
    cond do
      number == 0 && number2 == 0 -> ""
      number == 0 && number2 != 0 -> Map.get(@names, number2)
      number == 1 && number2 == 0 -> "ten"
      number == 1 && number2 == 1 -> "eleven"
      number == 1 && number2 == 2 -> "twelve"
      number == 1 && number2 == 3 -> "thirteen"
      number == 1 && number2 == 5 -> "fifteen"
      number == 1 && number2 == 8 -> "eighteen"
      number == 1 -> Map.get(@names, number2) <> "teen"
      number == 2 && number2 == 0 -> "twenty"
      number == 2 -> "twenty-" <> Map.get(@names, number2)
      number == 3 && number2 == 0 -> "thirty"
      number == 3 -> "thirty-" <> Map.get(@names, number2)
      number == 4 && number2 == 0 -> "forty"
      number == 4 -> "forty-" <> Map.get(@names, number2)
      number == 5 && number2 == 0 -> "fifty"
      number == 5 -> "fifty-" <> Map.get(@names, number2)
      number == 8 && number2 == 0 -> "eighty"
      number == 8 -> "eighty-" <> Map.get(@names, number2)
      number2 == 0 -> Map.get(@names, number) <> "ty"
      true -> Map.get(@names, number) <> "ty-" <> Map.get(@names, number2)
    end
  end
end
