defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      is_shouting?(input) and is_question?(input) -> "Calm down, I know what I'm doing!"
      is_shouting?(input) -> "Whoa, chill out!"
      is_question?(input) -> "Sure."
      is_silent?(input) -> "Fine. Be that way!"
      :true -> "Whatever."
    end
  end

  defp is_shouting?(input), do: !(input =~  ~r/[[:lower:]]/) and input =~  ~r/[[:upper:]]/
  defp is_question?(input), do: input =~  ~r/\?\s*$/
  defp is_silent?(input), do: !(input =~  ~r/[\w\d]/)
end
