defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite(strings) do
    base =
      strings
    |> Stream.map(fn x -> ["For want of a #{x} ", "the #{x} was lost.\n"] end)
    |> Enum.to_list()
    |> List.flatten()

    first_part =
      base
    |> Enum.take_every(2)
    |> List.delete_at(-1)

    second_part =
      base
    |> Kernel.--(first_part)
    |> List.delete_at(0)
    |> List.delete_at(-2)

    first_part
    |> Enum.zip_with(second_part, fn a, b -> a <> b end)
    |> Enum.concat(["And all for the want of a #{hd(strings)}.\n"])
    |> Enum.join()
    end
end
