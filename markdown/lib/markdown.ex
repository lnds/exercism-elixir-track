defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map_join(&process/1)
    |> patch_list
    |> bold_text
    |> emphasize
  end

  defp process("#" <> text), do:  parse_header(text)
  defp process("* " <> text), do: enclose_with_tag(text, "li")
  defp process(text), do: enclose_with_tag(text, "p")


  defp parse_header(text, level \\ 1)
  defp parse_header("#" <> text, level), do: parse_header(text, level + 1)
  defp parse_header(" " <> text, level), do: enclose_with_tag(text, "h#{level}")

  defp enclose_with_tag(text, tag), do: "<#{tag}>#{text}</#{tag}>"

  defp patch_list(text) do
    text
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>",  "</li></ul>")
  end

  @strong_regex ~r/__([^_]*)__/
  defp bold_text(text), do: String.replace(text, @strong_regex, "<strong>\\1</strong>")


  @emphasize_regex ~r/_([^_]*)_/
  defp emphasize(text), do: String.replace(text, @emphasize_regex, "<em>\\1</em>")

end
