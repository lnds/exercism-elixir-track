defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, b) when b <= 1, do: {:error, "output base must be >= 2"}
  def convert(_, b, _) when b <= 1, do: {:error, "input base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}

  def convert(digits, input_base, output_base) do
    if valid_digits(digits, input_base) do
      do_conversion(digits, input_base, output_base)
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp do_conversion(digits, input_base, output_base) do
    n = digits |> Enum.reduce(0, &(&1 + input_base * &2))

    list =
      Stream.unfold(n, fn
        0 -> nil
        n -> {rem(n, output_base), div(n, output_base)}
      end)
      |> Enum.to_list()
      |> Enum.reverse()

    if Enum.empty?(list) do
      {:ok, [0]}
    else
      {:ok, list}
    end
  end

  defp valid_digits(digits, base) do
    digits |> Enum.all?(&(&1 >= 0 && &1 < base))
  end
end
