defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[^\w\d\s',-]/u, "")
    |> String.split(~r/[\s,_]/)
    |> Enum.reject(fn x -> x == "" end)
    |> Enum.map(fn x -> String.replace_prefix(x, "'", "")|> String.replace_suffix("'", "") end)
    |> Enum.frequencies()
  end
end
