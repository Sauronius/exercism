defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @commands %{0 => "wink", 1 => "double blink", 2 => "close your eyes", 3 => "jump"}

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> Integer.to_charlist(2)
    |> prepare_and_order()
    |> Enum.map(fn {index, x} -> if x == ?1 do
        Map.fetch!(@commands, index)
    else
      []
      end end)
    |> List.flatten()
  end

  @spec prepare_and_order([integer()]) :: list({non_neg_integer(), non_neg_integer()})
  defp prepare_and_order(int_list) do
    if Enum.count(int_list) > 4 do
      if Enum.at(int_list, -5) == ?1 do
        int_list
        |> Enum.slice(-4..-1)
        |> Enum.reverse()
        |> Enum.with_index(fn x, index -> {index, x} end)
        |> Enum.reverse()
      else
        int_list
        |> Enum.slice(-4..-1)
        |> Enum.reverse()
        |> Enum.with_index(fn x, index -> {index, x} end)
      end
    else
      ['0' | ['0' | ['0' | ['0' | ['0' | int_list]]]]]
      |> Enum.slice(-4..-1)
      |> Enum.reverse()
      |> Enum.with_index(fn x, index -> {index, x} end)
    end
  end
end
