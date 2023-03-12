defmodule AllYourBase do

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    case check(digits, input_base, output_base) do
      {:error, message} -> {:error, message}
      _ -> digits
        |> from_base(input_base)
        |> to_base(output_base)
    end
  end

  @spec from_base(list(), integer()) :: integer()
  def from_base(list, base) do
    list
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {value, index} -> base ** index * value end)
    |> Enum.sum()
  end

  @spec to_base(integer(), integer()) :: tuple()
  def to_base(number, base) do
    {:ok, res_list(number, [], base)}
  end
  def res_list(0, sum, _base) do
    case sum do
      [] -> [0]
      _ -> sum
    end
  end
  def res_list(number, sum, base), do: res_list(div(number, base), [rem(number, base) | sum], base)

  @spec check(list(), integer(), integer()) :: nil | {:error, String.t()}
  def check(list, input_base, output_base) do
    if(output_base < 2) do
      {:error, "output base must be >= 2"}
    else
      if(input_base < 2) do
        {:error, "input base must be >= 2"}
      else
        if(Enum.any?(list, fn x -> (x < 0 || x >= input_base) end)) do
          {:error, "all digits must be >= 0 and < input base"}
        end
      end
    end
  end
end
