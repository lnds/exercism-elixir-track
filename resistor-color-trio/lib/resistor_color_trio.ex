defmodule ResistorColorTrio do
  @map %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {integer, :ohms | :kiloohms}
  def label([first, second, third | _]) do
    value = (@map[first] * 10 + @map[second]) * Integer.pow(10, @map[third])

    if value > 1000 do
      {value / 1000, :kiloohms}
    else
      {value, :ohms}
    end
  end
end
