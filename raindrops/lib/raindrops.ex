defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    result =
      ""
      |> factor(number, 3, "Pling")
      |> factor(number, 5, "Plang")
      |> factor(number, 7, "Plong")

    if result == "" do
      "#{number}"
    else
      result
    end
  end

  defp factor(str, number, base, word) do
    if rem(number, base) == 0 do
      str <> word
    else
      str
    end
  end
end
