defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u"]
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(fn x -> any_start(x) end)
    |> Enum.into("", fn x -> x <> " " end)
    |> String.trim()
  end

  @spec any_start(String.t()) :: String.t()
  def any_start(phrase) do
    cond do
      String.starts_with?(phrase, ["x", "y"]) and !is_vowel?(String.at(phrase, 1)) ->
        phrase <> "ay"
      String.starts_with?(phrase, @vowels) ->
        phrase <> "ay"
      String.starts_with?(phrase, "qu") ->
        phrase <> "qu"
        |> String.slice(2..20)
        |> any_start()
      true ->
        phrase <> String.first(phrase)
        |> String.slice(1..20)
        |> any_start()
    end
  end

  @spec is_vowel?(String.t()) :: boolean()
  defp is_vowel?(letter) do
    @vowels
    |> Enum.find_value(false, fn x -> x == letter end)
  end
end
