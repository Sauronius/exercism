defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @default_names [:kincaid, :alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet,
                  :ileana, :joseph, :larry]
  @plant_names %{"V" => :violets, "C" => :clover, "R" => :radishes, "G" => :grass}

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    nsn = Enum.sort(student_names, &(&1 <= &2))

    list3 = info_string
    |> String.split("\n")
    |> Stream.map(fn x -> Regex.split(~r{}, x, trim: true) end)
    |> Stream.map(&Stream.chunk_every(&1, 2))
    |> Enum.zip()
    |> Enum.map(fn{x, y} -> List.to_tuple(x ++ y) end)
    |> Enum.map(fn{a, b, x, y} -> {Map.get(@plant_names, a), Map.get(@plant_names, b), Map.get(@plant_names, x), Map.get(@plant_names, y)} end)

    populated_map =
      nsn
    |> Stream.zip(list3)
    |> Enum.into(%{})

    for y <- nsn, into: %{} do
      {y, {}}
    end
    |> Map.merge(populated_map)
  end
end
