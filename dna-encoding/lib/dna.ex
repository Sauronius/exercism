defmodule DNA do
  @spec encode_nucleotide(non_neg_integer()) :: byte()
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  @spec decode_nucleotide(byte()) :: non_neg_integer()
  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  @spec encode(charlist()) :: bitstring()
  def encode(dna) do
    encode_p(dna, <<0::size(0)>>)
  end

  defp encode_p([head | tail], encoded) do
    encode_p(tail, <<encoded::bitstring, encode_nucleotide(head)::4>>)
  end

  defp encode_p([], encoded) do
    encoded
  end

  @spec decode(bitstring()) :: charlist()
  def decode(dna) do
    decode_p(dna, '')
  end

  defp decode_p(<<head::4, tail::bitstring>>, decoded) do
    decode_p(tail, decoded ++ [decode_nucleotide(head)])
  end

  defp decode_p(<<0::0>>, decoded) do
    decoded
  end
end
