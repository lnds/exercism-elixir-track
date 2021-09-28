defmodule Username do
  def sanitize([]), do: []

  def sanitize([h | t]) do
    case h do
      ?ä -> 'ae' ++ sanitize(t)
      ?ö -> 'oe' ++ sanitize(t)
      ?ü -> 'ue' ++ sanitize(t)
      ?ß -> 'ss' ++ sanitize(t)
      h when h in 'abcdefghijklmnopqrstuvwxyz_' -> [h | sanitize(t)]
      _ -> sanitize(t)
    end
  end
end
