defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(""), do: true

  def isogram?(sentence) do
    letters =
      sentence
      |> String.downcase()
      |> String.codepoints()
      |> Enum.filter(&String.match?(&1, ~r/^\p{L}$/u))

    ul =
      letters
      |> Enum.uniq()
      |> length

    ul > 0 and ul == length(letters)
  end
end
