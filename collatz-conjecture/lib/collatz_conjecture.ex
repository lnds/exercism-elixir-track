defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()

  def calc(0), do: raise(FunctionClauseError)
  def calc(1), do: 0

  def calc(n) when is_integer(n) do
    cond do
      n < 0 -> raise(FunctionClauseError)
      rem(n, 2) == 0 -> 1 + calc(div(n, 2))
      true -> 1 + calc(3 * n + 1)
    end
  end
end
