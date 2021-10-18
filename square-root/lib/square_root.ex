defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    Stream.iterate(0, &(&1 + 1)) |> Enum.take_while(&(&1 * &1 <= radicand)) |> Enum.max()
  end
end
