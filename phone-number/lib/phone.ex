defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    num_seq = raw |> String.to_charlist() |> Enum.filter(&alphanumeric?/1)
    all_digit = num_seq |> Enum.all?(&(&1 in ?0..?9))
    len_num = length(num_seq)
    [first_digit | rest] = num_seq
    [_, _, first_exchange | _] = rest

    cond do
      len_num == 11 && first_digit == ?1 ->
        List.to_string(rest)

      len_num >= 11 || len_num <= 9 || first_digit == ?1 || first_digit == ?0 ||
        first_exchange == ?0 || first_exchange == ?1 || !all_digit ->
        "0000000000"

      true ->
        List.to_string(num_seq)
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    number(raw) |> String.to_charlist() |> Enum.take(3) |> List.to_string()
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    num = number(raw)
    "(#{String.slice(num, 0..2)}) #{String.slice(num, 3..5)}-#{String.slice(num, 6..9)}"
  end

  defp alphanumeric?(c) do
    c in ?a..?z || c in ?A..?Z || c in ?0..?9
  end
end
