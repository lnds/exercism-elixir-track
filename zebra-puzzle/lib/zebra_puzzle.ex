defmodule ZebraPuzzle do
  @doc """
  Determine who drinks the water
  """
  @spec drinks_water() :: atom
  def drinks_water() do
    [%{resident: resident} | _] =
      solve()
      |> Enum.filter(fn %{beverage: beverage} -> beverage == :water end)

    resident
  end

  @doc """
  Determine who owns the zebra
  """
  @spec owns_zebra() :: atom
  def owns_zebra() do
    [%{resident: resident} | _] =
      solve()
      |> Enum.filter(fn %{pet: pet} -> pet == :zebra end)

    resident
  end

  @residents ~w(norwegian englishman spaniard ukrainian japanese)a
  @colors ~w(red blue green ivory yellow)a
  @beverages ~w(coffee tea milk orange_juice water)a
  @smokes ~w(old_gold kools chesterfields lucky_strike parliaments)a
  @pets ~w(dog snails fox horse zebra)a
  defp solve() do
    houses =
      for i <- 1..5, c <- @colors, r <- @residents, b <- @beverages, s <- @smokes, p <- @pets do
        %{position: i, color: c, resident: r, beverage: b, smoke: s, pet: p}
      end

    filtered =
      houses
      # 2. The Englishman lives in the red house.
      |> direct_rule(:color, :red, :resident, :englishman)
      # 3. The Spaniard owns the dog.
      |> direct_rule(:resident, :spaniard, :pet, :dog)
      # 4. Coffee is drunk in the green house.
      |> direct_rule(:beverage, :coffee, :color, :green)
      # 5. The Ukrainian drinks tea.
      |> direct_rule(:resident, :ukrainian, :beverage, :tea)
      # 7. The Old Gold smoker owns snails.
      |> direct_rule(:smoke, :old_gold, :pet, :snails)
      # 8. Kools are smoked in the yellow house.
      |> direct_rule(:smoke, :kools, :color, :yellow)
      # 9. Milk is drunk in the middle house.
      |> direct_rule(:beverage, :milk, :position, 3)
      # 10. The Norwegian lives in the first house.
      |> direct_rule(:resident, :norwegian, :position, 1)
      # 13. The Lucky Strike smoker drinks orange juice.
      |> direct_rule(:smoke, :lucky_strike, :beverage, :orange_juice)
      # 14. The Japanese smokes Parliaments.
      |> direct_rule(:resident, :japanese, :smoke, :parliaments)
      # 15. The Norwegian lives next to the blue house.
      |> direct_rule(:color, :blue, :position, 2)

    l1 =
      filtered
      |> Enum.filter(fn h -> h.position == 1 end)

    l2 = filtered |> Enum.filter(fn h -> h.position == 2 end)
    l3 = filtered |> Enum.filter(fn h -> h.position == 3 end)
    l4 = filtered |> Enum.filter(fn h -> h.position == 4 end)
    l5 = filtered |> Enum.filter(fn h -> h.position == 5 end)

    houses =
      for h1 <- l1, h2 <- l2, h3 <- l3, h4 <- l4, h5 <- l5 do
        [h1, h2, h3, h4, h5]
      end

    houses
    |> Enum.uniq()
    |> Enum.filter(&well_formed/1)
    |> Enum.filter(&rule_6/1)
    |> Enum.filter(&rule_11/1)
    |> Enum.filter(&rule_12/1)
    |> Enum.filter(&rule_15/1)
    |> Enum.concat()
    |> Enum.uniq()
  end

  defp well_formed([h1, h2, h3, h4, h5]) do
    h1.resident != h2.resident && h1.resident != h3.resident && h1.resident != h4.resident &&
      h1.resident != h5.resident &&
      h2.resident != h3.resident && h2.resident != h4.resident && h2.resident != h5.resident &&
      h3.resident != h4.resident && h3.resident != h5.resident &&
      h4.resident != h5.resident &&
      h1.color != h2.color && h1.color != h3.color && h1.color != h4.color &&
      h1.color != h5.color &&
      h2.color != h3.color && h2.color != h4.color && h2.color != h5.color &&
      h3.color != h4.color && h3.color != h5.color &&
      h4.color != h5.color &&
      h1.smoke != h2.smoke && h1.smoke != h3.smoke && h1.smoke != h4.smoke &&
      h1.smoke != h5.smoke &&
      h2.smoke != h3.smoke && h2.smoke != h4.smoke && h2.smoke != h5.smoke &&
      h3.smoke != h4.smoke && h3.smoke != h5.smoke &&
      h4.smoke != h5.smoke &&
      h1.pet != h2.pet && h1.pet != h3.pet && h1.pet != h4.pet &&
      h1.pet != h5.pet &&
      h2.pet != h3.pet && h2.pet != h4.pet && h4.pet != h5.pet &&
      h3.pet != h4.pet && h3.pet != h5.pet &&
      h4.pet != h5.pet &&
      h1.beverage != h2.beverage && h1.beverage != h3.beverage && h1.beverage != h4.beverage &&
      h1.beverage != h5.beverage &&
      h2.beverage != h3.beverage && h2.beverage != h4.beverage && h3.beverage != h5.beverage &&
      h3.beverage != h4.beverage && h3.beverage != h5.beverage &&
      h4.beverage != h5.beverage &&
      h1.position != h2.position && h1.position != h3.position && h1.position != h4.position &&
      h1.position != h5.position &&
      h2.position != h3.position && h2.position != h4.position && h2.position != h5.position &&
      h3.position != h4.position && h3.position != h5.position &&
      h4.position != h5.position
  end

  # 6. The green house is immediately to the right of the ivory house.
  defp rule_6([h1, h2, h3, h4, h5]) do
    cond do
      h1.color == :ivory && h2.color == :green -> true
      h2.color == :ivory && h3.color == :green -> true
      h3.color == :ivory && h4.color == :green -> true
      h4.color == :ivory && h5.color == :green -> true
      true -> false
    end
  end

  # 11. The man who smokes Chesterfields lives in the house next to the man with the fox.
  defp rule_11([h1, h2, h3, h4, h5]) do
    cond do
      h1.smoke == :chesterfields and h2.pet == :fox -> true
      h2.smoke == :chesterfields and h3.pet == :fox -> true
      h3.smoke == :chesterfields and h4.pet == :fox -> true
      h4.smoke == :chesterfields and h5.pet == :fox -> true
      h1.pet == :fox and h2.smoke == :chesterfields -> true
      h2.pet == :fox and h3.smoke == :chesterfields -> true
      h3.pet == :fox and h4.smoke == :chesterfields -> true
      h4.pet == :fox and h5.smoke == :chesterfields -> true
      true -> false
    end
  end

  # 12. Kools are smoked in the house next to the house where the horse is kept.
  defp rule_12([h1, h2, h3, h4, h5]) do
    cond do
      h1.smoke == :kools and h2.pet == :horse -> true
      h2.smoke == :kools and h3.pet == :horse -> true
      h3.smoke == :kools and h4.pet == :horse -> true
      h4.smoke == :kools and h5.pet == :horse -> true
      h1.pet == :horse and h2.smoke == :kools -> true
      h2.pet == :horse and h3.smoke == :kools -> true
      h3.pet == :horse and h4.smoke == :kools -> true
      h4.pet == :horse and h5.smoke == :kools -> true
      true -> false
    end
  end

  # 15. The Norwegian lives next to the blue house.
  defp rule_15([h1, h2, h3, h4, h5]) do
    cond do
      h1.resident == :norwegian and h2.color == :blue -> true
      h2.resident == :norwegian and h3.color == :blue -> true
      h3.resident == :norwegian and h4.color == :blue -> true
      h4.resident == :norwegian and h5.color == :blue -> true
      h1.color == :blue and h2.resident == :norwegian -> true
      h2.color == :blue and h3.resident == :norwegian -> true
      h3.color == :blue and h3.resident == :norwegian -> true
      h4.color == :blue and h5.resident == :norwegian -> true
      true -> false
    end
  end

  defp direct_rule(list, field1, value1, field2, value2) do
    list
    |> Enum.filter(fn house ->
      cond do
        house[field1] == value1 and house[field2] == value2 -> true
        house[field1] == value1 -> false
        house[field2] == value2 -> false
        true -> true
      end
    end)
  end
end
