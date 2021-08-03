defmodule Bob do

  def asking?(input), do: String.ends_with?(input, "?")

  def yelling?(input) do
    letters = Enum.any?(String.codepoints(input), &String.match?(&1, ~r/^\p{L}$/u))
    is_upper = String.upcase(input) == input
    letters && is_upper
  end

  def silent?(input) do
    input == ""
  end

  def hey(input) do
    input = String.trim(input)
    cond do
      asking?(input) && yelling?(input) -> "Calm down, I know what I'm doing!"
      yelling?(input) -> "Whoa, chill out!"
      asking?(input) -> "Sure."
      silent?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end
