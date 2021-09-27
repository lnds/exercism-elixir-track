defmodule GuessingGame do
  def compare(secret_number, guess \\ :no_guess)
  def compare(n, n), do: "Correct"
  def compare(secret_number, :no_guess), do: "Make a guess"
  def compare(secret_number, guess) when secret_number + 1 < guess, do: "Too high"
  def compare(secret_number, guess) when secret_number > guess + 1, do: "Too low"
  def compare(_, _), do: "So close"
end
