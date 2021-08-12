defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    norm = normalize(base)

    candidates
    |> Enum.filter(&(normalize(&1) == norm))
    |> Enum.filter(&(String.downcase(&1) != String.downcase(base)))
  end

  defp normalize(string) do
    string |> String.downcase() |> String.to_charlist() |> Enum.sort()
  end
end
