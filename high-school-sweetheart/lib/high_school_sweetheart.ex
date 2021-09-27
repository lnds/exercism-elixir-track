defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name |> String.trim() |> String.first()
  end

  def initial(name) do
    (String.capitalize(name) |> first_letter()) <> "."
  end

  def initials(full_name) do
    String.split(full_name) |> Enum.map(&initial/1) |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    res = ~s"""
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{initials(full_name1)}  +  #{initials(full_name2)}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """

    res
  end
end
