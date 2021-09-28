defmodule NameBadge do
  def print(id, name, department) do
    dept = if department == nil, do: "OWNER", else: String.upcase(department)

    if id == nil do
      "#{name} - #{dept}"
    else
      "[#{id}] - #{name} - #{dept}"
    end
  end
end
