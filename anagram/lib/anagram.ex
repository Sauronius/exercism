defmodule Anagram do

  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(fn x -> String.length(x) == String.length(base) end)
    |> Enum.filter(fn x -> String.downcase(x) != String.downcase(base) end)
    |> ultra_compare(base)
  end

  @spec ultra_compare([String.t()], String.t()) :: [String.t()]
  def ultra_compare(list, word) do
    temp = word
      |> String.downcase()
      |> String.splitter("", trim: true)
      |> Enum.sort()

    list
    |> Enum.filter(fn x ->
      emtp = x
      |> String.downcase()
      |> String.splitter("", trim: true)
      |> Enum.sort()
        emtp == temp
         end)
  end
end
