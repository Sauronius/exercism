defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    textlength = String.length(plaintext)
    keylength = String.length(key)
    if textlength > keylength do
      newkey = String.duplicate(key, :erlang.ceil((textlength / keylength)))
      rot_ht(plaintext, newkey, [])
      |> List.to_string()
    else
      rot_ht(plaintext, key, [])
      |> List.to_string()
    end
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    textlength = String.length(ciphertext)
    keylength = String.length(key)
    if textlength > keylength do
      newkey = String.duplicate(key, :erlang.ceil((textlength / keylength)))
      rot_ht2(ciphertext, newkey, [])
      |> List.to_string()
    else
      rot_ht2(ciphertext, key, [])
      |> List.to_string()
    end
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    Enum.map(1..length, fn _x -> Enum.random(?a..?z) end)
    |> List.to_string()
  end

  @spec rot_ht(binary(), binary(), list()) :: [char()]
  defp rot_ht(<<>>, _, acc), do: Enum.reverse(acc)
  defp rot_ht(<<x::utf8, rest::binary>>, <<y::utf8, rest2::binary>>, acc) do
    rot_ht(rest, rest2, [rotate_up(x, y) | acc])
  end

  @spec rot_ht2(binary(), binary(), list()) :: [char()]
  defp rot_ht2(<<>>, _, acc), do: Enum.reverse(acc)
  defp rot_ht2(<<x::utf8, rest::binary>>, <<y::utf8, rest2::binary>>, acc) do
    rot_ht2(rest, rest2, [rotate_down(x, y) | acc])
  end

  @spec rotate_up(integer(), integer()) :: integer()
  defp rotate_up(number, number2) do
    if number + number2 - ?a > ?z do
      rotate_up(number - (?z - ?a) - 1, number2)
    else
      number + number2 - ?a
    end
  end

  @spec rotate_down(integer(), integer()) :: integer()
  defp rotate_down(number, number2) do
    if number - number2 + ?a >= ?a do
      number - number2 + ?a
    else
      rotate_down(number + (?z - ?a) + 1, number2)
    end
  end
end
