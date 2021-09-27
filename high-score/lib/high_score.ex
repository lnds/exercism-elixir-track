defmodule HighScore do
  def new() do
    %{}
  end

  @initial 0
  def add_player(scores, name, score \\ @initial) do
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    Map.put(scores, name, @initial)
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, &(&1 + score))
  end

  def get_players(scores) do
    # Please implement the get_players/1 function
    Map.keys(scores)
  end
end
