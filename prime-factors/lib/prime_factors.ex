defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(1), do: []
  def factors_for(2), do: [2]

  def factors_for(number) do
    factors_for(2, number, []) |> Enum.reverse()
  end

  def factors_for(i, n, list) do
    cond do
      i * i > n ->
        [n | list]

      i == n ->
        [n | list]

      rem(n, i) == 0 ->
        factors_for(2, div(n, i), [i | list])

      true ->
        factors_for(i + 1, n, list)
    end
  end
end
