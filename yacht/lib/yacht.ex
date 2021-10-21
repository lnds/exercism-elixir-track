defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(:yacht, [a, a, a, a, a]), do: 50

  def score(:ones, dice) do
    dice |> Enum.filter(&(&1 == 1)) |> Enum.sum()
  end

  def score(:twos, dice) do
    2 * count_same(dice, 2)
  end

  def score(:threes, dice) do
    3 * count_same(dice, 3)
  end

  def score(:fours, dice) do
    4 * count_same(dice, 4)
  end

  def score(:fives, dice) do
    5 * count_same(dice, 5)
  end

  def score(:sixes, dice) do
    6 * count_same(dice, 6)
  end

  def score(:full_house, dice) do
    f = dice |> Enum.frequencies()

    cond do
      Map.values(f) |> Enum.sort() == [2, 3] -> Enum.sum(dice)
      true -> 0
    end
  end

  def score(:four_of_a_kind, dice) do
    f = dice |> Enum.frequencies()

    cond do
      Map.values(f) |> Enum.sort() == [5] ->
        Map.keys(f) |> Enum.map(fn k -> if f[k] == 5, do: k * 4, else: 0 end) |> Enum.sum()

      Map.values(f) |> Enum.sort() == [1, 4] ->
        Map.keys(f) |> Enum.map(fn k -> if f[k] == 4, do: k * 4, else: 0 end) |> Enum.sum()

      true ->
        0
    end
  end

  def score(:little_straight, dice) do
    if Enum.sort(dice) == [1, 2, 3, 4, 5] do
      30
    else
      0
    end
  end

  def score(:big_straight, dice) do
    if Enum.sort(dice) == [2, 3, 4, 5, 6] do
      30
    else
      0
    end
  end

  def score(:choice, dice) do
    Enum.sum(dice)
  end

  def score(_, _) do
    0
  end

  defp count_same(dice, value) do
    dice |> Enum.filter(&(&1 == value)) |> Enum.count()
  end
end
