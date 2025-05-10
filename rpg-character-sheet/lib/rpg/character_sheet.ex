defmodule RPG.CharacterSheet do
  def welcome() do
    # Please implement the welcome/0 function
    IO.puts("Welcome! Let's fill out your character sheet together.")
    :ok
  end

  def ask_name() do
    IO.gets("What is your character's name?\n") |> to_string() |> String.trim()
  end

  def ask_class() do
    IO.gets("What is your character's class?\n") |> to_string() |> String.trim()
  end

  def ask_level() do
    IO.gets("What is your character's level?\n")
    |> to_string()
    |> String.trim()
    |> String.to_integer()
  end

  def run() do
    welcome()
    name = ask_name()
    class = ask_class()
    level = ask_level()
    %{class: class, level: level, name: name} |> IO.inspect(label: "\nYour character")
  end
end
