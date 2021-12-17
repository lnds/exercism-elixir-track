defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}

  def build_tree([], []), do: {:ok, {}}

  def build_tree([a], [a]), do: {:ok, {{}, a, {}}}

  def build_tree(preorder, inorder) when length(preorder) != length(inorder) do
    {:error, "traversals must have the same length"}
  end

  def build_tree(preorder, inorder) do
    invalid = length(preorder -- inorder) != 0 or length(inorder -- preorder) != 0

    notunique =
      Enum.uniq(preorder) |> length != length(preorder) or
        Enum.uniq(inorder) |> length != length(inorder)

    cond do
      invalid -> {:error, "traversals must have the same elements"}
      notunique -> {:error, "traversals must contain unique items"}
      true -> {:ok, make_node(preorder, inorder)}
    end
  end

  defp make_node([], []), do: nil

  defp make_node([a], _), do: {{}, a, {}}

  defp make_node([h | t] = preorder, inorder) do
    pos = Enum.find_index(inorder, &(&1 == h))
    left = Enum.take(inorder, pos)
    right = Enum.drop(inorder, pos + 1)
    pre_left = Enum.slice(t, 0, length(left))
    pre_right = Enum.slice(t, length(left), length(preorder))
    {make_node(pre_left, left), h, make_node(pre_right, right)}
  end
end
