defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean

  def chain?([]), do: true

  def chain?([{x,y}]), do: x == y

  def chain?([{x,y}|pile]) do
    pile
    |> Enum.filter(fn {a,b} -> a == y or b == y end)
    |> Enum.any?(&([combine({x, y}, &1) | remove(&1, pile)] |> chain?))
  end

  defp remove(x, [h | tail]) do
    if h == x do
      tail
    else
      [h | remove(x, tail)]
    end
  end

  defp combine({a, b}, {c, d}) do
    if b == c do
      {a, d}
    else
      {a, c}
    end
  end
end
