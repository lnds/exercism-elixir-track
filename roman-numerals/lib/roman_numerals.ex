defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    unit(part(number, 1000), "M", "", "") 
    <> unit(part(number, 100), "C", "D", "M")
    <> unit(part(number, 10), "X", "L", "C") 
    <> unit(part(number, 1), "I", "V", "X") 
  end

  def unit(part, base, mid, limit) do
    case part do
      x when x < 4 -> String.duplicate(base, x)
      4 -> "#{base}#{mid}"
      x when x < 9 -> mid <> String.duplicate(base, x - 5)
      9 -> base <> limit
      _ -> ""
    end
  end


  def part(num, digit) do
    num |> rem(digit * 10) |> div(digit)
  end
end
