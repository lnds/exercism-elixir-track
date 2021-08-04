defmodule Bowling do
  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  defstruct [:frame, :frames]


  @spec start() :: any
  def start do
    %Bowling{frame: 0, frames: List.duplicate({nil, nil, :not_played}, 12)}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  def roll(_, pins) when pins < 0, do: {:error, "Negative roll is invalid"}

  def roll(game, pins) do
    if game_ended(game) do
      {:error, "Cannot roll after game is over"}
    else
      frame = Enum.at(game.frames, game.frame)
      case roll_frame(frame, pins) do
        {:ok, frame} -> update_frames(game, frame)
        error -> error
      end
    end
  end

  defp update_frames(game, frame) do
    game = %Bowling{game| frames: List.replace_at(game.frames, game.frame, frame)}
    case frame do
      {_, _, :open} -> %Bowling{game| frame: game.frame + 1}
      {_, _, :strike} -> %Bowling{game| frame: game.frame + 1}
      {_, _, :spare} -> %Bowling{game| frame: game.frame + 1}
      _ -> game
    end
  end

  defp roll_frame(frame, pins) do
    case frame do
      {nil, nil, :not_played} when pins < 10 -> {:ok, {pins, nil,  %{waiting: (10 - pins)}}}
      {nil, nil, :not_played} when pins == 10 -> {:ok, {pins, nil, :strike}}
      {score, nil, %{waiting: _}} when pins + score == 10 -> {:ok, {score, pins, :spare}}
      {score, nil, %{waiting: _}} when pins + score < 10 -> {:ok, {score, pins, :open}}
      _ -> {:error, "Pin count exceeds pins on the lane"}
    end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()
  def score(game) do
    if !game_ended(game) do
      {:error, "Score cannot be taken until the end of the game"}
    else
      game.frames
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.map(&calc_score/1)
      |> Enum.sum
    end

  end

  defp calc_score([f1, f2, f3]) do
    {s21, s22, _} = f2
    {s31, _, _} = f3
    case f1 do
      {_, _, :strike} -> 10 + pins(s21, 0) + pins(s22, pins(s31, 0))
      {_, _, :spare}  -> 10 + pins(s21, 0)
      {a, b, :open} -> a + b
      _ -> 0
    end
  end

  defp pins(n, d), do: if(n == nil, do: d, else: n)

  defp game_ended(game) do
    {_, _, a} = Enum.at(game.frames, 9)
    {_, _, b} = Enum.at(game.frames, 10)
    {_, _, c} = Enum.at(game.frames, 11)
    case a do
      :strike -> (b == :strike && c != :not_played) || (b == :open || b == :spare)
      :spare -> b != :not_played
      :open -> true
      _ -> false
    end
  end
end
