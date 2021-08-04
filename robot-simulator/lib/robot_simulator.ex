defmodule RobotSimulator do

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any

  def create(), do:  %{direction: :north, position: {0, 0}}

  def create(dir, pos) do
    cond do
      not Enum.member?([:north, :south, :east, :west], dir) -> {:error, "invalid direction"}
      !is_tuple(pos) or is_nil(pos)
      or tuple_size(pos) != 2
      or !is_integer(elem(pos, 0))
      or !is_integer((elem(pos, 1))) -> {:error, "invalid position"}
      true -> %{direction: dir, position: pos}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
      |> String.graphemes
      |> Enum.reduce(robot, &move(&2, &1))
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot), do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot), do: robot.position

  @turn_right %{north: :east, east: :south, south: :west, west: :north}
  @turn_left  %{north: :west, west: :south, south: :east, east: :north}

  defp advance({x, y}, :north), do: {x, y+1}
  defp advance({x, y}, :south), do: {x, y-1}
  defp advance({x, y}, :west),  do: {x-1, y}
  defp advance({x, y}, :east),  do: {x+1, y}

  defp move(error={:error, _}, _), do: error

  defp move(robot, "R"), do: %{robot| direction: @turn_right[robot.direction]}
  defp move(robot, "L"), do: %{robot| direction: @turn_left[robot.direction]}
  defp move(robot, "A"), do:  %{robot| position: advance(robot.position, robot.direction)}
  defp move(_, _), do: {:error, "invalid instruction"}

end
