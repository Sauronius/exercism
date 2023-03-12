defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> rot_ht([])
    |> Stream.chunk_every(5)
    |> Stream.intersperse(" ")
    |> Enum.to_list()
    |> List.to_string()
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> rot_ht([])
    |> List.to_string()
  end

  @spec rot_ht(binary(), list()) :: [char()]
  defp rot_ht(<<>>, acc), do: Enum.reverse(acc)
  defp rot_ht(<<x::utf8, rest::binary>>, acc) do
    cond do
      is_letter?(x) -> rot_ht(rest, [?a + ?z - x | acc])
      is_number?(x) -> rot_ht(rest, [x | acc])
      true -> rot_ht(rest, acc)
    end
  end

  @spec is_letter?(char()) :: boolean()
  defp is_letter?(x), do: x >= ?a and x <= ?z

  @spec is_number?(char()) :: boolean()
  defp is_number?(x), do: x >= ?0 and x <= ?9
end
