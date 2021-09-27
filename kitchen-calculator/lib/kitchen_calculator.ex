defmodule KitchenCalculator do
  def get_volume({_, volume}) do
    volume
  end

  def to_milliliter({unit, volume} = input) do
    case unit do
      :cup -> {:milliliter, 240 * volume}
      :fluid_ounce -> {:milliliter, 30 * volume}
      :teaspoon -> {:milliliter, 5 * volume}
      :tablespoon -> {:milliliter, 15 * volume}
      _ -> input
    end
  end

  def from_milliliter({_, volume} = volume_pair, unit) do
    volume =
      case unit do
        :cup -> volume / 240
        :fluid_ounce -> volume / 30
        :teaspoon -> volume / 5
        :tablespoon -> volume / 15
        _ -> volume
      end

    {unit, volume}
  end

  def convert(volume_pair, unit) do
    to_milliliter(volume_pair) |> from_milliliter(unit)
  end
end
