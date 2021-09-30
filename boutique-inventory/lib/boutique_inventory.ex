defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort(inventory, &(&1.price <= &2.price))
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def increase_quantity(item, count) do
    q =
      item.quantity_by_size
      |> Enum.map(fn {k, v} -> {k, v + count} end)
      |> Enum.into(%{})

    %{item | quantity_by_size: q}
  end

  def total_quantity(item) do
    item.quantity_by_size |> Enum.map(fn {_, v} -> v end) |> Enum.sum()
  end
end
