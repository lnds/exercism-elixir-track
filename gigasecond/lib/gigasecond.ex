defmodule Gigasecond do
  @gigasecond 1_000_000_000

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, base} = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
    result = NaiveDateTime.add(base, @gigasecond)
    {{result.year, result.month, result.day}, {result.hour, result.minute, result.second}}
  end
end
