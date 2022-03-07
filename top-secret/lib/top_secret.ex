defmodule TopSecret do
  def to_ast(str) do
    {:ok, ast} = Code.string_to_quoted(str)
    ast
  end

  def decode_secret_message_part({:def, _, body}=ast, acc) do
    decode_secret_message_parts(body, ast, acc)
  end

  def decode_secret_message_part({:defp, _, body}=ast, acc) do
    decode_secret_message_parts(body, ast, acc)
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp decode_secret_message_parts([{:when, _, guard}|body], ast, acc) do
    arity = hd(guard) |> elem(2) |> len
    name = hd(guard) |> elem(0) |> Atom.to_string() |> String.slice(0, arity)
    {ast, [name|acc]}
  end

  defp decode_secret_message_parts(body, ast, acc) do
    arity = hd(body) |> elem(2) |> len
    name = hd(body) |> elem(0) |> Atom.to_string() |> String.slice(0, arity)
    {ast, [name|acc]}
  end


  def decode_secret_message(string) do
    {ast, funcs} = to_ast(string) |> Macro.postwalk([], &traverse/2)
    funcs |> Enum.reduce([""], fn ast, acc ->
      {_, new_acc} = decode_secret_message_part(ast, acc)
      new_acc
    end)
    |> Enum.join()
  end

  defp traverse({:def, _, body}=node, acc) do
    {node, [node | acc]}
  end

  defp traverse({:defp, _, body}=node, acc) do
    {node, [node | acc]}
  end

  defp traverse(node, acc), do: {node, acc}

  defp len(nil), do: 0
  defp len(lst), do: length(lst)


end
