defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    colors
    |> Enum.slice(0..1)
    |> Enum.map(&code/1)
    |> List.update_at(0, &(&1 * 10))
    |> Enum.reduce(0, fn x, acc -> x + acc end)
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
