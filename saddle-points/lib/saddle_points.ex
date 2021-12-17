defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []

  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn s -> String.split(s) |> Enum.map(&String.to_integer/1) end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    rows(str) |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(""), do: []

  def saddle_points(str) do
    rs = rows(str)
    cs = columns(str)

    pos =
      for r <- Enum.to_list(0..(length(rs) - 1)) do
        for c <- Enum.to_list(0..(length(cs) - 1)) do
          row = Enum.at(rs, r)
          col = Enum.at(cs, c)
          n = row |> Enum.at(c)
          sr = row |> Enum.all?(fn x -> n >= x end)
          sc = col |> Enum.all?(fn x -> n <= x end)

          if sr and sc do
            {r + 1, c + 1}
          end
        end
      end

    pos |> Enum.concat() |> Enum.filter(&(&1 != nil))
  end
end
