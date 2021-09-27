defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove([]), do: []
  def remove([h | t]), do: t

  def first([]), do: []
  def first([h | t]), do: h

  def count([]), do: 0
  def count([_ | t]), do: 1 + count(t)

  def exciting_list?([]), do: false

  def exciting_list?([h | t]) do
    if h == "Elixir" do
      true
    else
      exciting_list?(t)
    end
  end
end
