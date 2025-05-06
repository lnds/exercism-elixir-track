defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(1), do: 0

  def calc(n) when n > 0 and rem(n, 2) == 0, do: 1 + calc(div(n, 2))
  def calc(n) when n > 0 and is_integer(n), do: 1 + calc(3 * n + 1)
end
