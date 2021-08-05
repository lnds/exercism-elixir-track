defmodule Forth do
  @opaque evaluator :: any

  defstruct [:stack, :defs]

  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %{stack: [], defs: %{}}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
    String.upcase(s)
    |> String.split(~r/[^[:graph:]+-\/\*:;]/u)
    |> parse(ev)
  end

  defp parse([], ev), do: ev

  defp parse([token|tokens], %{stack: stack, defs: definitions}=ev) do
    {ev, tokens} = if Map.has_key?(definitions, token) do
      {parse_value(ev, token), tokens}
    else
       case token do
        "+" -> {add(ev), tokens}
        "-" -> {sub(ev), tokens}
        "*" -> {mul(ev), tokens}
        "/" -> {div(ev), tokens}
        "DUP"  ->  {dup(ev), tokens}
        "DROP" ->  {drop(ev), tokens}
        "SWAP" -> {swap(ev), tokens}
        "OVER" -> {over(ev), tokens}
        ":" -> parse_def(tokens, ev)
        _ -> {parse_value(ev, token), tokens}
      end
    end
    parse(tokens, ev)
  end


  defp parse_def(tokens, ev) do

    {def_body, tokens} = Enum.split_while(tokens, &(&1 != ";"))
    if tokens == [] or hd(tokens) != ";" do
      raise Forth.InvalidWord
    end
    [word|body] = def_body
    if word =~ ~r/\d+/ do
      raise Forth.InvalidWord
    end
    ev = %{ev| defs: Map.put(ev.defs, word, body) }
    {ev, tl(tokens)}
  end

  defp parse_value(%{stack: stack}=ev, token) do
    try do
      %{ev| stack: [String.to_integer(token)|stack]}
    rescue
        ArgumentError -> try_eval_def(token, ev)
    end
  end

  defp try_eval_def(word, %{stack: stack, defs: definitions}=ev) do
    if !Map.has_key?(definitions, word) do
      raise Forth.UnknownWord
    else
      forth = %{stack: stack, defs: %{}}
      code = Map.get(definitions, word)
      result = parse(code, forth)
      %{ev| stack: result.stack}
    end
  end

  defp over(%{stack: []}), do: raise Forth.StackUnderflow

  defp over(%{stack: [_]}), do: raise Forth.StackUnderflow

  defp over(%{stack: [_ | [b | _]]}=ev) do
    %{ev | stack: [b| ev.stack]}
  end

  defp swap(%{stack: []}), do: raise Forth.StackUnderflow

  defp swap(%{stack: [_]}), do: raise Forth.StackUnderflow

  defp swap(%{stack: [a | [b | rest]]}=ev) do
    %{ev | stack: [b | [a | rest]]}
  end

  defp dup(%{stack: []}), do: raise Forth.StackUnderflow

  defp dup(%{stack: [a | _]}=ev) do
    %{ev | stack: [a|ev.stack]}
  end

  defp drop(%{stack: []}), do: raise Forth.StackUnderflow

  defp drop(%{stack: [_ | rest]}=ev) do
    %{ev | stack: rest}
  end

  defp add(%{stack: []}), do: raise Forth.StackUnderflow

  defp add(%{stack: [a | [b | rest]]}=ev) do
    %{ev| stack: [(a + b) | rest]}
  end

  defp sub(%{stack: []}), do: raise Forth.StackUnderflow

  defp sub(%{stack: [a | [b |rest]]}=ev) do
    %{ev| stack: [(b - a) | rest]}
  end

  defp mul(%{stack: []}), do: raise Forth.StackUnderflow

  defp mul(%{stack: [a | [b | rest]]}=ev) do
    %{ev| stack: [(b * a) | rest]}
  end

  defp div(%{stack: []}), do: raise Forth.StackUnderflow

  defp div(%{stack: [a | [b | rest]]}=ev) do
    if a == 0 do
      raise Forth.DivisionByZero
    else
      %{ev | stack: [Integer.floor_div(b, a) | rest]}
    end
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()

  def format_stack(%{stack: []}), do: ""

  def format_stack(%{stack: stack}) do
    stack
      |> Enum.reverse
      |> Enum.map(&inspect(&1))
      |> Enum.join(" ")
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
