defmodule PigLatin do
  @vowel ~r/^([aeiou]|[xy][b-df-h-jnp-tv-z]).+$/
  @conso ~r/^(s?qu|[^aeiou]+)(.+)$/

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    cond do
      word =~ @vowel ->
        word <> "ay"

      word =~ @conso ->
        Regex.replace(@conso, word, "\\2\\1ay")

      true ->
        word
    end
  end
end
