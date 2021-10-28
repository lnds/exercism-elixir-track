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

  defp previous(1), do: ["I don't know why she swallowed the fly. Perhaps she'll die."]

  defp previous(2) do
    [
      "It wriggled and jiggled and tickled inside her.",
      "She swallowed the #{animal(2)} to catch the #{animal(1)}.",
      "I don't know why she swallowed the fly. Perhaps she'll die."
    ]
  end

  defp previous(3) do
    [
      "How absurd to swallow a bird!",
      "She swallowed the #{animal(3)} to catch the #{animal(2)} that wriggled and jiggled and tickled inside her.",
      "She swallowed the #{animal(2)} to catch the #{animal(1)}.",
      "I don't know why she swallowed the fly. Perhaps she'll die."
    ]
  end

  defp previous(4) do
    [
      "Imagine that, to swallow a cat!",
      "She swallowed the #{animal(4)} to catch the #{animal(3)}.",
      "She swallowed the #{animal(3)} to catch the #{animal(2)} that wriggled and jiggled and tickled inside her.",
      "She swallowed the #{animal(2)} to catch the #{animal(1)}.",
      "I don't know why she swallowed the fly. Perhaps she'll die."
    ]
  end

  defp previous(5) do
    [
      "What a hog, to swallow a dog!",
      "She swallowed the #{animal(5)} to catch the #{animal(4)}.",
      "She swallowed the #{animal(4)} to catch the #{animal(3)}.",
      "She swallowed the #{animal(3)} to catch the #{animal(2)} that wriggled and jiggled and tickled inside her.",
      "She swallowed the #{animal(2)} to catch the #{animal(1)}.",
      "I don't know why she swallowed the fly. Perhaps she'll die."
    ]
  end

  defp previous(6) do
    [
      "Just opened her throat and swallowed a goat!",
      "She swallowed the #{animal(6)} to catch the #{animal(5)}.",
      "She swallowed the #{animal(5)} to catch the #{animal(4)}.",
      "She swallowed the #{animal(4)} to catch the #{animal(3)}.",
      "She swallowed the #{animal(3)} to catch the #{animal(2)} that wriggled and jiggled and tickled inside her.",
      "She swallowed the #{animal(2)} to catch the #{animal(1)}.",
      "I don't know why she swallowed the fly. Perhaps she'll die."
    ]
  end

  defp previous(7) do
    [
      "I don't know how she swallowed a cow!",
      "She swallowed the #{animal(7)} to catch the #{animal(6)}.",
      "She swallowed the #{animal(6)} to catch the #{animal(5)}.",
      "She swallowed the #{animal(5)} to catch the #{animal(4)}.",
      "She swallowed the #{animal(4)} to catch the #{animal(3)}.",
      "She swallowed the #{animal(3)} to catch the #{animal(2)} that wriggled and jiggled and tickled inside her.",
      "She swallowed the #{animal(2)} to catch the #{animal(1)}.",
      "I don't know why she swallowed the fly. Perhaps she'll die."
    ]
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
