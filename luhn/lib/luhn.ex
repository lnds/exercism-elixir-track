defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    if not check?(String.trim(number)) do
      false
    else
      n =
        number
        |> String.to_charlist()
        |> Enum.filter(&(&1 >= ?0 && &1 <= ?9))
        |> Enum.map(&(&1 - ?0))
        |> Enum.reverse()
        |> Stream.zip_with(Stream.cycle([1, 2]), fn a, b -> a * b end)
        |> Enum.to_list()
        |> Enum.map(fn x -> if x > 9, do: x - 9, else: x end)
        |> Enum.sum()

      rem(n, 10) == 0
    end
  end

  defp check?(number) do
    String.length(number) > 1 &&
      String.to_charlist(number) |> Enum.all?(&(&1 == ?\s || (&1 >= ?0 && &1 <= ?9)))
  end
end
