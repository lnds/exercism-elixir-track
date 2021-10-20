defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))

  def matrix(0), do: []

  def matrix(dimension) do
    dims = for a <- 0..(dimension - 1), b <- 0..(dimension - 1), do: {a, b}

    dims
    |> Enum.map(fn {row, col} ->
      cell(dimension, row, col)
    end)
    |> Enum.chunk_every(dimension)
  end

  defp cell(dimension, row, col) do
    cond do
      row == 0 -> col + 1
      col == 0 -> 4 * dimension - 3 - row
      row == dimension - 1 -> 3 * dimension - 2 - col
      col == dimension - 1 -> dimension + row
      true -> (dimension - 1) * 4 + cell(dimension - 2, row - 1, col - 1)
    end
  end
end
