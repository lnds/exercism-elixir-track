defmodule Zipper do

  @type t :: %Zipper{focus: any, up: any, by: any}

  defstruct [:focus, :up, :by]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{focus: bin_tree,  up: nil, by: nil}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(zipper) do
    if zipper.up == nil do
      zipper.focus
    else
      to_tree(zipper.up)
    end
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper) do
    zipper.focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil

  def left(zipper) do
    if zipper.focus.left == nil do
      nil
    else
      %Zipper{zipper| up: zipper, focus: zipper.focus.left, by: :left}
    end
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil

  def right(zipper) do
    if zipper.focus.right == nil do
      nil
    else
      %Zipper{zipper| up: zipper, focus: zipper.focus.right, by: :right}
    end
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(zipper) do
    if zipper.up == nil do
      nil
    else
      upper = zipper.up
      %Zipper{zipper| focus: upper.focus, up: upper.up, by: upper.by}
    end
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()


  def set_value(zipper, value) do
    tree = %BinTree{zipper.focus| value: value}
    new_zipper = %Zipper{zipper| focus: tree}
    fix_up(tree, zipper, new_zipper)
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
    tree = %BinTree{zipper.focus| left: left}
    new_zipper = %Zipper{zipper| focus: tree}
    fix_up(tree, zipper, new_zipper)
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
    tree = %BinTree{zipper.focus| right: right}
    new_zipper = %Zipper{zipper| focus: tree}
    fix_up(tree, zipper, new_zipper)
  end

  defp fix_up(tree, zipper, new_zipper) do
    if zipper.up == nil do
      new_zipper
    else
      case zipper.by do
        :left  -> %Zipper{zipper|focus: tree, up: set_left(zipper.up, tree)}
        :right -> %Zipper{zipper|focus: tree, up: set_right(zipper.up, tree)}
        true -> new_zipper
      end
    end
  end
end
