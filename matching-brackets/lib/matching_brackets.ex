defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.codepoints()
    |> Enum.filter(&(&1 in ["{", "[", "(", ")", "]", "}"]))
    |> sign_by_sign([])
  end

  @spec sign_by_sign(list(), list()) :: boolean()
  defp sign_by_sign([], []), do: :true
  defp sign_by_sign([], _lo), do: :false
  defp sign_by_sign([h | t], lo) do
    hlo = List.first(lo)
    case h do
      "{" -> sign_by_sign(t, [h | lo])
      "[" -> sign_by_sign(t, [h | lo])
      "(" -> sign_by_sign(t, [h | lo])
      ")" -> if hlo == "(" do sign_by_sign(t, List.delete_at(lo, 0)) else :false end
      "]" -> if hlo == "[" do sign_by_sign(t, List.delete_at(lo, 0)) else :false end
      "}" -> if hlo == "{" do sign_by_sign(t, List.delete_at(lo, 0)) else :false end
    end
  end
end
