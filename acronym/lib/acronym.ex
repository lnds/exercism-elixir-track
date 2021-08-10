defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.split(~r/[ _-]+/, string)
    |> Enum.map(&sep_word/1)
    |> Enum.join()
  end

  defp sep_word(word) do
    first = String.at(word, 0)

    rest =
      word
      |> String.to_charlist()
      |> Enum.drop_while(&(&1 in ?A..?Z))
      |> Enum.filter(&(&1 in ?A..?Z))
      |> List.to_string()

    (first <> rest) |> String.upcase()
  end
end
