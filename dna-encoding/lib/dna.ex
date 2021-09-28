defmodule DNA do
  @map %{?\s => 0b000, ?A => 0b001, ?C => 0b0010, ?G => 0b0100, ?T => 0b1000}
  @pam %{0b000 => ?\s, 0b001 => ?A, 0b0010 => ?C, 0b0100 => ?G, 0b1000 => ?T}

  def encode_nucleotide(code_point) do
    @map[code_point]
  end

  def decode_nucleotide(encoded_code) do
    @pam[encoded_code]
  end

  def encode([]), do: ""
  def encode([h | t]), do: <<encode_nucleotide(h)::4, encode(t)::bitstring>>

  def decode(""), do: ''
  def decode(<<value::4, rest::bitstring>>), do: [decode_nucleotide(value) | decode(rest)]
end
