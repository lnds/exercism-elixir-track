defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """

  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, charlist()}

  def convert(input) when rem(length(input), 4) != 0, do: {:error, 'invalid line count'}
  def convert([" _ ", "| |", "|_|", "   "]), do: {:ok, "0"}
  def convert(["   ", "  |", "  |", "   "]), do: {:ok, "1"}
  def convert([" _ ", " _|", "|_ ", "   "]), do: {:ok, "2"}
  def convert([" _ ", " _|", " _|", "   "]), do: {:ok, "3"}
  def convert(["   ", "|_|", "  |", "   "]), do: {:ok, "4"}
  def convert([" _ ", "|_ ", " _|", "   "]), do: {:ok, "5"}
  def convert([" _ ", "|_ ", "|_|", "   "]), do: {:ok, "6"}
  def convert([" _ ", "  |", "  |", "   "]), do: {:ok, "7"}
  def convert([" _ ", "|_|", "|_|", "   "]), do: {:ok, "8"}
  def convert([" _ ", "|_|", " _|", "   "]), do: {:ok, "9"}

  def convert([h | _] = input) when length(input) == 4 do
    cond do
      !valid_elements(input) ->
        {:error, 'invalid column count'}

      String.length(h) == 3 ->
        {:ok, "?"}

      true ->
        {:ok,
         input
         |> Enum.map(fn s ->
           s |> String.codepoints() |> Enum.chunk_every(3) |> Enum.map(&Enum.join/1)
         end)
         |> Enum.zip()
         |> Enum.map(&Tuple.to_list/1)
         |> Enum.map(&convert/1)
         |> Enum.map(fn {_, v} -> v end)
         |> Enum.join()}
    end
  end

  def convert(input) do
    {:ok,
     input
     |> Enum.chunk_every(4)
     |> Enum.map(&convert/1)
     |> Enum.map(fn {_, v} -> v end)
     |> Enum.join(",")}
  end

  defp valid_elements(input) do
    not Enum.any?(input, &(rem(String.length(&1), 3) != 0))
  end
end
