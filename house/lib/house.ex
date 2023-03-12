defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @activity {"lay in", "ate", "killed", "worried", "tossed", "milked", "kissed",
              "married", "woke", "kept", "belonged to"}
  @character {"house that Jack built.", "malt", "rat", "cat", "dog",
              "cow with the crumpled horn", "maiden all forlorn",
              "man all tattered and torn", "priest all shaven and shorn",
              "rooster that crowed in the morn", "farmer sowing his corn",
              "horse and the hound and the horn"}

  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    for x <- start..stop, into: "" do
      "This is the " <> elem(@character, x - 1) <> do_recite(x - 1) <> "\n"
    end
  end

  @spec do_recite(non_neg_integer()) :: String.t()
  defp do_recite(0), do: ""
  defp do_recite(line) do
    " that " <> elem(@activity, line - 1) <> " the " <> elem(@character, line - 1) <> do_recite(line - 1)
  end
end
