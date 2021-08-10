defmodule RotationalCipher do
  @alphabet "abcdefghijklmnopqrstuvwxyz"

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    cipher = if shift < 0, do: rot_right(abs(shift)), else: rot_left(shift)
    collate = Enum.zip(String.to_charlist(@alphabet), cipher) |> Map.new()

    text
    |> String.to_charlist()
    |> Enum.map(fn letter ->
      cond do
        letter in ?a..?z -> collate[letter]
        letter in ?A..?Z -> upper(collate[lower(letter)])
        true -> letter
      end
    end)
    |> List.to_string()
  end

  defp rot_left(n) do
    (@alphabet <>
       @alphabet)
    |> String.to_charlist()
    |> Enum.drop(n)
    |> Enum.take(26)
  end

  defp rot_right(n) do
    rot_left(26 - rem(n, 26))
  end

  defp lower(letter), do: letter - ?A + ?a
  defp upper(letter), do: letter - ?a + ?A
end
