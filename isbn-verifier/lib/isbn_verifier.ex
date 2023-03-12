defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    ns = Regex.replace(~r/-/, isbn, "")
    Regex.named_captures(~r/(?<cap>[A-W]|[Y-Z])/, isbn) == nil &&
    String.length(ns) == 10 && ns =~ ~r/[0-9]{9}[0-9 | X]{1}/ &&
    sum_check?(Regex.split(~r{}, ns, trim: true))

  end

  @spec sum_check?([String.t()]) :: boolean
  defp sum_check?(list) do
    sum = list
    |> Stream.map(fn x -> if x =~ ~r/X/ do 10 else String.to_integer(x) end end)
    |> Stream.zip_with(10..1, fn a, b -> a * b end)
    |> Enum.sum()

    rem(sum, 11) === 0
  end
end
