defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    String.split(path, ".") |> extract_path(data)
  end

  defp extract_path([], _), do: nil

  defp extract_path([h], data), do: data[h]

  defp extract_path([h | t], data) do
    r = data[h]

    if r != nil do
      extract_path(t, r)
    else
      nil
    end
  end

  def get_in_path(data, path) do
    keys = String.split(path, ".")
    Kernel.get_in(data, keys)
  end
end
