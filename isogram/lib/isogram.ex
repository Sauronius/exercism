defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    Regex.replace(~r/[- | \s]/, sentence, "")
    |> String.downcase()
    |> String.split("", trim: true)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.all?(fn x -> x == 1 end)
  end
end
