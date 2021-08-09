defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    result = []
    <<rest::3, rev::1, jump::1, close_your_eyes::1, double_blink::1, wink::1>> = <<code>>

    result = if wink == 1, do: ["wink" | result], else: result
    result = if double_blink == 1, do: ["double blink" | result], else: result
    result = if close_your_eyes == 1, do: ["close your eyes" | result], else: result
    result = if jump == 1, do: ["jump" | result], else: result

    if rev == 1 do
      result
    else
      result |> Enum.reverse()
    end
  end
end
