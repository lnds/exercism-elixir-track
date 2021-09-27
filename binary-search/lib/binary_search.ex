defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found

  def search({}, _), do: :not_found

  def search({n}, key) do
    if n == key do
      {:ok, 0}
    else
      :not_found
    end
  end

  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  def search(numbers, key, l, r) do
    if l > r do
      :not_found
    else
      m = l + div(r - l, 2)

      cond do
        elem(numbers, m) < key -> search(numbers, key, m + 1, r)
        elem(numbers, m) > key -> search(numbers, key, l, m - 1)
        true -> {:ok, m}
      end
    end
  end
end
