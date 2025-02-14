defmodule LanguageList do
  def new() do
    [] 
  end

  def add(list, language) do
    [language | list] 
  end

  def remove([]), do: []
  def remove([_]), do: []
  def remove([_|t]), do: t 

  def first([]), do: []
  def first([a]), do: a
  def first([h|_]), do: h  # Please implement the first/1 function

  def count([]), do: 0
  def count([_]), do: 1
  def count([_|t]), do: 1 + count(t)

  def functional_list?([]), do: false
  def functional_list?([h|t]) do
    if h == "Elixir", do: true, else: functional_list?(t)
  end

end
