defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.to_charlist()
    |> Enum.reduce([], &match_char?/2)
    |> Enum.empty?()
  end

  defp match_char?(c = ?(, stack), do: [c | stack]
  defp match_char?(c = ?{, stack), do: [c | stack]
  defp match_char?(c = ?[, stack), do: [c | stack]
  defp match_char?(c = ?), stack), do: consume(stack, c)
  defp match_char?(c = ?}, stack), do: consume(stack, c)
  defp match_char?(c = ?], stack), do: consume(stack, c)

  defp match_char?(_, stack), do: stack

  @open_bracket %{?) => ?(, ?} => ?{, ?] => ?[}
  defp consume([], _), do: []

  defp consume([head | tail] = stack, c) do
    if @open_bracket[c] === head do
      tail
    else
      [?  | stack]
    end
  end
end
