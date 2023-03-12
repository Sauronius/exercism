defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label(colors) do
    sum =
      colors
    |> Enum.slice(0..2)
    |> Enum.map(&code/1)
    |> List.update_at(2, &List.duplicate(0, &1))
    |> List.flatten()
    |> Enum.reduce("", fn x, acc -> acc <> Integer.to_string(x) end)
    |> String.to_integer()

    if sum > 999 do
      {div(sum, 1000), :kiloohms}
    else
      {sum, :ohms}
    end
  end

  @spec code(atom()) :: integer()
  defp code(:black), do: 0
  defp code(:brown), do: 1
  defp code(:red), do: 2
  defp code(:orange), do: 3
  defp code(:yellow), do: 4
  defp code(:green), do: 5
  defp code(:blue), do: 6
  defp code(:violet), do: 7
  defp code(:grey), do: 8
  defp code(:white), do: 9
end
