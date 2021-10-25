defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    header = "Team                           | MP |  W |  D |  L |  P"

    tally =
      input
      |> Enum.map(fn line ->
        String.split(line, ";")
      end)
      |> Enum.filter(fn items -> length(items) == 3 end)
      |> Enum.reduce(%{}, fn [team1, team2, result], scores ->
        case result do
          "win" ->
            scores
            |> Map.update(team1, %{win: 1, loss: 0, draw: 0}, fn score ->
              Map.update(score, :win, 1, &(&1 + 1))
            end)
            |> Map.update(team2, %{win: 0, loss: 1, draw: 0}, fn score ->
              Map.update(score, :loss, 1, &(&1 + 1))
            end)

          "draw" ->
            scores
            |> Map.update(team1, %{win: 0, loss: 0, draw: 1}, fn score ->
              Map.update(score, :draw, 1, &(&1 + 1))
            end)
            |> Map.update(team2, %{win: 0, loss: 0, draw: 1}, fn score ->
              Map.update(score, :draw, 1, &(&1 + 1))
            end)

          "loss" ->
            scores
            |> Map.update(team1, %{win: 0, draw: 0, loss: 1}, fn score ->
              Map.update(score, :loss, 1, &(&1 + 1))
            end)
            |> Map.update(team2, %{win: 1, draw: 0, loss: 0}, fn score ->
              Map.update(score, :win, 1, &(&1 + 1))
            end)

          _ ->
            scores
        end
      end)
      |> Enum.sort_by(fn {_, %{win: w, draw: d}} -> w * 3 + d end, &>=/2)
      |> Enum.map(fn {k, score} ->
        "#{String.pad_trailing(k, 30)} " <>
          "| #{fmt_int(score.win + score.draw + score.loss, 2)} " <>
          "| #{fmt_int(score.win, 2)} " <>
          "| #{fmt_int(score.draw, 2)} " <>
          "| #{fmt_int(score.loss, 2)} " <>
          "| #{fmt_int(score.win * 3 + score.draw, 2)}"
      end)
      |> Enum.join("\n")

    if tally != "" do
      header <> "\n" <> tally
    else
      header
    end
  end

  defp fmt_int(i, pad) do
    Integer.to_string(i) |> String.pad_leading(pad)
  end
end
