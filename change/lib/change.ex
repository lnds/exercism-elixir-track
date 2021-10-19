defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}

  def generate(_, 0), do: {:ok, []}
  def generate(coins, target), do: do_generate(Enum.sort(coins, :desc), target)

  defp do_generate(coins, target) do
    v =
      Enum.to_list(1..target)
      |> Enum.reduce(%{}, &Map.put(&2, &1, min_coins(&2, &1, coins)))
      |> Map.get(target)

    if v == [] do
      {:error, "cannot change"}
    else
      {:ok, v}
    end
  end

  defp min_coins(cache, amount, coins) do
    coins
    |> Enum.filter(&(&1 <= amount))
    |> Enum.map(&[&1 | Map.get(cache, amount - &1, [])])
    |> Enum.reverse()
    |> Enum.filter(&(Enum.sum(&1) == amount))
    |> Enum.sort_by(&length/1)
    |> List.first([])
    |> Enum.sort()
  end
end
