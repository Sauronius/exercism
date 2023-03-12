defmodule RnaTranscription do
  @dna_to_rna [{?G, ?C}, {?C, ?G}, {?T, ?A}, {?A, ?U}]
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.map(&single_transcription/1)
  end

  @spec single_transcription(char()) :: char()
  defp single_transcription(nucleotide) do
    @dna_to_rna
    |> Enum.find('', fn x -> nucleotide == elem(x, 0) end)
    |> elem(1)
  end
end
