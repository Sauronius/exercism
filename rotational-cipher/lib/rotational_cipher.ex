defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> rot_ht(shift, [])
    |> Enum.reverse()
    |> List.to_string()
  end

  @spec rot_ht(binary(), non_neg_integer(), list()) :: [char()]
  defp rot_ht(<<>>, _shift, acc), do: acc
  defp rot_ht(<<x::utf8, rest::binary>>, shift, acc) do
    cond do
      is_letter?(x) -> if rotated?(x, x + shift) do
          rot_ht(rest, shift, [x + shift - 26 | acc])
         else
          rot_ht(rest, shift, [x + shift | acc])
         end
      true -> rot_ht(rest, shift, [x | acc])
    end
  end

  @spec is_letter?(char()) :: boolean()
  defp is_letter?(x), do: (x >= ?A and x <= ?Z) or (x >= ?a and x <= ?z)

  @spec rotated?(char(), char()) :: boolean()
  defp rotated?(prev, new) do
    (prev <= ?z and new > ?z) or (prev <= ?Z and new > ?Z)
  end
end
