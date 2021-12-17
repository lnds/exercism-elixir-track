defmodule FoodChain do
  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    verses(start, stop) |> Enum.join("\n")
  end

  defp verses(start, start), do: [verse(start)]

  defp verses(start, stop) when start < stop do
    [verse(start) | verses(start + 1, stop)]
  end

  defp verse(i), do: (stansas(i) |> Enum.join("\n")) <> "\n"

  defp stansas(i) when i <= 8 do
    ["I know an old lady who swallowed a #{animal(i)}." | previous(i)]
  end

  defp just(1) do
    "I don't know why she swallowed the fly. Perhaps she'll die."
  end

  defp just(3) do
    "She swallowed the #{animal(3)} to catch the #{animal(2)} that wriggled and jiggled and tickled inside her."
  end

  defp just(i) do
    "She swallowed the #{animal(i)} to catch the #{animal(i - 1)}."
  end

  defp justs(1), do: [just(1)]
  defp justs(i), do: [just(i) | justs(i - 1)]

  defp previous(1), do: justs(1)

  defp previous(2) do
    ["It wriggled and jiggled and tickled inside her." | justs(2)]
  end

  defp previous(3) do
    ["How absurd to swallow a bird!" | justs(3)]
  end

  defp previous(4) do
    ["Imagine that, to swallow a cat!" | justs(4)]
  end

  defp previous(5) do
    ["What a hog, to swallow a dog!" | justs(5)]
  end

  defp previous(6) do
    ["Just opened her throat and swallowed a goat!" | justs(6)]
  end

  defp previous(7) do
    ["I don't know how she swallowed a cow!" | justs(7)]
  end

  defp previous(8) do
    ["She's dead, of course!"]
  end

  defp animal(1), do: "fly"
  defp animal(2), do: "spider"
  defp animal(3), do: "bird"
  defp animal(4), do: "cat"
  defp animal(5), do: "dog"
  defp animal(6), do: "goat"
  defp animal(7), do: "cow"
  defp animal(8), do: "horse"
end
