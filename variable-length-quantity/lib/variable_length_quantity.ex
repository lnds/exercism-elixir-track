defmodule VariableLengthQuantity do
  use Bitwise

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode(integers :: [integer]) :: binary
  def encode(integers), do: Enum.reduce(integers, <<>>, &encode/2)

  defp encode(0, acc), do: acc <> <<0>>
  defp encode(x, acc), do: acc <> encode(x, 0, <<>>)

  defp encode(0, _, acc), do: acc
  defp encode(x, b, acc), do: encode(x >>> 7, 1, <<b::1, x::7, acc::bitstring>>)

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(bytes :: binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bytes), do: decode(bytes, 0, [])

  defp decode(<<>>, 0, []), do: {:error, "incomplete sequence"}
  defp decode(<<>>, 0, acc), do: {:ok, Enum.reverse(acc)}
  defp decode(<<0::1, x::7, r::bitstring>>, i, acc), do: decode(r, 0, [i <<< 7 ||| x | acc])
  defp decode(<<1::1, x::7, r::bitstring>>, i, acc), do: decode(r, i <<< 7 ||| x, acc)
  defp decode(<<_::binary>>, _, _), do: {:error, "incomplete sequence"}
end
