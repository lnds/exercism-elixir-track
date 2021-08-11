defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist
  def compare(a, b) when a === b, do: :equal

  def compare(a, b) do
    if Enum.count(a) > Enum.count(b) do
      compare_list(b, a, :superlist)
    else
      compare_list(a, b, :sublist)
    end
  end

  defp compare_list(short_list, long_list, result) do
    len = Enum.count(short_list)

    eq =
      long_list
      |> Enum.chunk_every(len, 1)
      |> Enum.any?(&(short_list === &1))

    if eq do
      result
    else
      :unequal
    end
  end
end
