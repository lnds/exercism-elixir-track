defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer

  def count([]), do: 0
  def count([_ | t]), do: count(t, 1)

  defp count([], n), do: n
  defp count([_|t], n), do: count(t, n+1)


  @spec reverse(list) :: list

  def reverse([]), do: []
  def reverse([h | t]), do: reverse(t, [h])

  defp reverse([], l), do: l
  defp reverse([h|t], l), do: reverse(t, [h | l])

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h|t], f), do: [f.(h) | map(t, f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([h | t], f) do
    if f.(h) do
      [h | filter(t, f)]
    else
      filter(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h|t], acc, f), do: reduce(t, f.(h, acc), f)

  @spec append(list, list) :: list
  def append([], []), do: []
  def append([], l), do: l
  def append(l, []), do: l
  def append([h], l), do: [h| l]
  def append([h|t], l), do: [h|append(t, l)]


  @spec concat([[any]]) :: [any]
  def concat(list) when is_list(list), do: concat(list, [])

  defp concat([], _), do: []
  defp concat([h|t], fl) when is_list(h), do: concat(append(concat(h, fl), t), fl)
  defp concat([h|[]], fl), do: [h | fl]
  defp concat([h|t], fl), do: [h | concat(t, fl)]

end
