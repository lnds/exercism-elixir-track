defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    cond do
      number == 0 -> "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
      number == 1 -> "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
      number == 2 -> "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n"
      number < 100 -> "#{number} bottles of beer on the wall, #{number} bottles of beer.\nTake one down and pass it around, #{number - 1} bottles of beer on the wall.\n"
      true -> ""
    end
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  def lyrics(), do: lyrics(99..0)

  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    range
      |> Enum.map(&verse(&1))
      |> Enum.join("\n")
  end
end
