defmodule HighSchoolSweetheart do
  def first_letter(name) do
    # Please implement the first_letter/1 function
    String.trim(name) |> String.first()
  end

  def initial(name) do
    # Please implement the initial/1 function
    String.upcase(first_letter(name)) <> "."
  end

  def initials(full_name) do
    # Please implement the initials/1 function
    [a, b] = String.split(full_name)
    initial(a) <> " " <> initial(b)
  end

  def pair(full_name1, full_name2) do
    #      ******       ******
    #    **      **   **      **
    #  **         ** **         **
    # **            *            **
    # **                         **
    # **     X. X.  +  X. X.     **
    #  **                       **
    #    **                   **
    #      **               **
    #        **           **
    #          **       **
    #            **   **
    #              ***
    #               *

    # Please implement the pair/2 function
    """
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
  end
end
