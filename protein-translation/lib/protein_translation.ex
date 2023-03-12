defmodule ProteinTranslation do
  @keyword_codon_list [AUG: "Methionine", UUU: "Phenylalanine", UUC: "Phenylalanine",
                       UUA: "Leucine", UUG: "Leucine", UCU: "Serine", UCC: "Serine",
                       UCA: "Serine", UCG: "Serine", UAU: "Tyrosine", UAC: "Tyrosine",
                       UGU: "Cysteine", UGC: "Cysteine", UGG: "Tryptophan",
                       UAA: "STOP", UAG: "STOP", UGA: "STOP"]
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    rna
    |> String.to_charlist()
    |> Enum.chunk_every(3)
    |> Enum.map(&List.to_string/1)
    |> Enum.map(&of_codon/1)
    |> Enum.map(&protein/1)
    |> result()
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    protein = Keyword.fetch(@keyword_codon_list, String.to_atom(codon))
    case protein do
      :error -> {:error, "invalid codon"}
      _ -> protein
    end
  end

  @spec protein({atom(), String.t()}) :: :error | String.t()
  defp protein({x, y}) do
    case x do
      :error -> :error
      :ok -> y
    end
  end

  @spec result(list()) :: {:ok, list(String.t())} | {:error, String.t()}
  defp result(list) do
    cond do
      (has_stop_before_error?(list) and has_error?(list)) or !has_error?(list) ->
        list
        |> Enum.take_while(fn x -> x != "STOP" end)
        |> to_tuple()
      has_error?(list) -> {:error, "invalid RNA"}
    end
  end

  @spec to_tuple(list(String.t())) :: {:ok, list(String.t())}
  defp to_tuple(list), do: {:ok, list}

  @spec has_stop_before_error?(list(String.t())) :: boolean()
  defp has_stop_before_error?(list) do
    has_stop =
      list
      |> Enum.find_index(fn x -> x == "STOP" end)
    has_error =
      list
      |> Enum.find_index(fn x -> x == :error end)

    has_stop < has_error
  end

  @spec has_error?(list(String.t())) :: boolean()
  defp has_error?(list) do
    has_error =
      list
      |> Enum.find(false, fn x -> x == :error end)
    has_error == :error
  end
end
