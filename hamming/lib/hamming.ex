defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}

  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2), do: {:error, "strands must be of equal length"}
  def hamming_distance(strand1, strand2) do
    cells1 = to_string(strand1) |> String.codepoints()
    cells2 = to_string(strand2) |> String.codepoints()
    diffs = Enum.zip(cells1, cells2) |> Enum.filter(fn {c1, c2} -> c1 != c2 end) |> Enum.count()
    {:ok, diffs}
  end
end
