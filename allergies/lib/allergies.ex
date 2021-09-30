defmodule Allergies do
  use Bitwise

  @allergenes ~w[eggs peanuts shellfish strawberries tomatoes chocolate pollen cats]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(0), do: []

  def list(flags) do
    Enum.to_list(0..7) |> Enum.filter(&bit_test(flags, &1)) |> Enum.map(&Enum.at(@allergenes, &1))
  end

  defp bit_test(flag, pos) do
    (flag &&& 1 <<< pos) != 0
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    list(flags) |> Enum.any?(&(&1 == item))
  end
end
