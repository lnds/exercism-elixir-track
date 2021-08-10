defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.to_charlist()
    |> Enum.chunk_by(&Function.identity/1)
    |> Enum.map(fn s ->
      count = Enum.count(s)
      char = <<List.first(s)::utf8>>

      cond do
        count == 0 -> ""
        count == 1 -> "#{char}"
        true -> "#{count}#{char}"
      end
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(""), do: ""

  def decode(string) do
    Regex.scan(~r/(\d*)?(\D)/, string)
    |> Enum.map(fn [_, l, c] ->
      len = int(l)
      List.duplicate(c, len)
    end)
    |> Enum.join()
  end

  defp int(""), do: 1
  defp int(l), do: String.to_integer(l)
end
