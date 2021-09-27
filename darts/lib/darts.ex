defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position :: position) :: integer
  def score({x, y}) do
    d = x * x + y * y

    cond do
      d <= 1.0 -> 10
      d <= 25.0 -> 5
      d <= 100.0 -> 1
      true -> 0
    end
  end
end
