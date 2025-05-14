defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\].*/
  end

  def split_line(line) do
    matches = Regex.split(~r/<[~=*-]*>/, line)

    if is_nil(matches) do
      [line]
    else
      matches
    end
  end

  def remove_artifacts(line) do
    matches = Regex.split(~r/end-of-line\d+/i, line)

    if is_nil(matches) do
      line
    else
      matches |> Enum.join()
    end
  end

  def tag_with_user_name(line) do
    matches = Regex.run(~r/.*User[ \t\n]+([^ \t\n]+).*/i, line)

    if is_nil(matches) do
      line
    else
      "[USER] #{matches |> List.last()} #{line}"
    end
  end
end
