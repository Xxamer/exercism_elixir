defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end
  defp do_encode([], count) do
    count
  end
  defp do_encode([nucleotide | remaining], count) do
    encoded_nucleotide = encode_nucleotide(nucleotide)
    updated_count =
      <<count::bitstring, encoded_nucleotide::4>>
    do_encode(remaining, updated_count)
  end

  def decode(dna) do
    do_decode(dna, ~c"")
  end

  defp do_decode(<<>>, count) do
    count
  end

  defp do_decode(<<encoded_nucleotide::4, remaining::bitstring>>, count) do
    nucleotide = decode_nucleotide(encoded_nucleotide)
    updated_count = count ++ [nucleotide]
    do_decode(remaining, updated_count)
  end
end
