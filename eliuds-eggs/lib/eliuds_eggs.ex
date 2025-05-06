defmodule EliudsEggs do
  import Bitwise

  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(0), do: 0
  def egg_count(1), do: 1

  def egg_count(number), do: egg_count(band(number, 0b0000001)) + egg_count(bsr(number, 1))
end
