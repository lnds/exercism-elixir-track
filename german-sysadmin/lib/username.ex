defmodule Username do
  def sanitize([]), do: []

  def sanitize([h | t]) do
    case h do
      ?ä -> ~c"ae" ++ sanitize(t)
      ?ö -> ~c"oe" ++ sanitize(t)
      ?ü -> ~c"ue" ++ sanitize(t)
      ?ß -> ~c"ss" ++ sanitize(t)
      h when h in ~c"abcdefghijklmnopqrstuvwxyz_" -> [h | sanitize(t)]
      _ -> sanitize(t)
    end
  end
end
