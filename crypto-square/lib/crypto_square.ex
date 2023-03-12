defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""
  def encode(str) do
    ns = str
    |> String.replace(~r/[^\w\d]/, "")
    |> String.downcase()

    columns = ns
    |> String.length()
    |> :math.sqrt()
    |> :math.ceil()
    |> round()

    ns
    |> Kernel.<>(String.duplicate(" ", space_count(String.length(ns), columns)))
    |> String.split("", trim: true)
    |> Enum.chunk_every(columns)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.join(" ")
  end

  @spec space_count(pos_integer(), pos_integer()) :: non_neg_integer()
  defp space_count(string_l, cols) do
    case rem(string_l, cols) do
      0 -> 0
      x -> cols - x
    end
  end
end
