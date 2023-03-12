defmodule Pangram do
  @letters ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
            "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    lc_sentence =
      sentence
      |> String.downcase()

    count =
      for letter <- @letters,
          String.contains?(lc_sentence, letter) do
            letter
          end
      |> Enum.count()

    count === 26
  end
end
