defmodule Username do
  @spec sanitize(charlist) :: charlist
  def sanitize(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

    # Please implement the sanitize/1 function
    case List.first(username) do
      nil -> []
      x when ((x>=?a and x<=?z) or x==?_) and tl(username) == [] -> [x]
      y when ((y>=?a and y<=?z) or y==?_) -> [y] ++ sanitize(tl(username))
      ?ä -> 'ae' ++ sanitize(tl(username))
      ?ö -> 'oe' ++ sanitize(tl(username))
      ?ü -> 'ue' ++ sanitize(tl(username))
      ?ß -> 'ss' ++ sanitize(tl(username))
      z when (z<?a or z>?z) and tl(username) != [] -> username |> List.delete(z) |> sanitize()
      _ -> ''
    end
  end
end
