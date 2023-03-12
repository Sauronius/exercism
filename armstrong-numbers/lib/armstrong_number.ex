defmodule ArmstrongNumber do

  @spec valid?(integer) :: boolean
  def valid?(number) do
    calculate_armstrong(number) === number
  end
  @spec calculate_armstrong(integer()) :: integer()
  def calculate_armstrong(number) do
    count =
      number
      |> Integer.to_string()
      |> String.length()

    number
    |> Integer.to_string()
    |> String.splitter("", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> List.foldl(0, fn x, acc -> x ** count + acc end)
  end
end
