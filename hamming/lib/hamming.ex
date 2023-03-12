defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    case (Enum.count(strand1) === Enum.count(strand2)) do
      false -> {:error, "strands must be of equal length"}
      true -> {:ok, distance(strand1, strand2)}
    end
   end

   @spec distance([char], [char]) :: non_neg_integer()
   def distance(str1, str2) do
    str1
    |> Enum.zip_reduce(str2, 0, fn x, y, acc ->
       if (x == y) do
         acc
       else acc + 1 end
       end)
   end
end
