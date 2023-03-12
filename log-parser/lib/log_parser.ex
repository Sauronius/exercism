defmodule LogParser do
  @spec valid_line?(String.t()) :: boolean()
  def valid_line?(line) do
    line =~ ~r/^\[(DEBUG|INFO|WARNING|ERROR)\].*/
  end

  @spec split_line(String.t()) :: list(String.t())
  def split_line(line) do
    Regex.split(~r/<[=~*-]*>/, line)
  end

  @spec remove_artifacts(String.t()) :: String.t()
  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  @spec tag_with_user_name(String.t()) :: String.t()
  def tag_with_user_name(line) do
    user = Regex.named_captures(~r/User[\s\t]+(?<u>\S+)/u, line)
    case user do
      :nil -> line
      _ -> "[USER] #{elem(Map.fetch(user, "u"), 1)} " <> line
    end
  end
end
