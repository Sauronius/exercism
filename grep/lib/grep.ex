defmodule Grep do
  @options %{"-v" => :false, "-n" => :false, "-i" => :true, "-l" => :false, "-x" => :false}
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    flag_map = for flag <- Map.keys(@options), into: %{} do
        if Enum.find(flags, fn x -> x == flag end) != nil do
          {flag, !Map.get(@options, flag)}
        else
          {flag, Map.get(@options, flag)}
        end
    end

    file_count = Enum.count(files)

    for file <- files, into: "" do
      process_p(file, pattern, flag_map, file_count)
    end
  end

  @spec process_p(String.t(), String.t(), map(), integer()) :: String.t()
  defp process_p(filename, pattern, flag_map, file_count) do
    filename
    |> Path.absname()
    |> File.stream!()
    |> Stream.with_index(1)
    |> find_lines(Map.get(flag_map, "-v"), Map.get(flag_map, "-i"), pattern)
    |> Stream.filter(fn {x, _y} -> x != "" end)
    |> with_full_lines(Map.get(flag_map, "-x"), Map.get(flag_map, "-v"), pattern)
    |> with_index(Map.get(flag_map, "-n"))
    |> with_name(file_count, filename)
    |> only_name(Map.get(flag_map, "-l"), filename)
    |> Enum.join("")
  end

  @spec find_lines(Enumerable.t(), boolean(), boolean(), String.t()) :: Enumerable.t()
  defp find_lines(enumerable, inverted, sensitive, pattern) do
    if !sensitive do
      enumerable
      |> Stream.map(fn {x, y} ->
            {match_return(x, elem(Regex.compile(pattern, "i"), 1), inverted), y}
        end)
    else
      enumerable
      |> Stream.map(fn {x, y} ->
            {match_return(x, elem(Regex.compile(pattern), 1), inverted), y}
        end)
    end
  end

  @spec with_full_lines(Enumerable.t(), boolean(), boolean(), String.t()) :: Enumerable.t()
  defp with_full_lines(enumerable, full_lines, inverted, pattern) do
    if full_lines && !inverted do
      Stream.filter(enumerable, fn {x, _y} -> String.length(x) - 1 == String.length(pattern) end)
    else
      enumerable
    end
  end

  @spec with_index(Enumerable.t(), boolean()) :: Enumerable.t()
  defp with_index(enumerable, with_number) do
    if with_number do
      Stream.map(enumerable, fn {x, y} -> Integer.to_string(y) <> ":" <> x end)
    else
      Stream.map(enumerable, fn {x, _y} -> x end)
    end
  end

  @spec with_name(Enumerable.t(), integer(), String.t()) :: Enumerable.t()
  defp with_name(enumerable, count, file_name) do
    if count > 1 do
      Stream.map(enumerable, fn x -> file_name <> ":" <> x end)
    else
      enumerable
    end
  end

  @spec only_name(Enumerable.t(), boolean(), String.t()) :: Enumerable.t()
  defp only_name(enumerable, name_only, file_name) do
    if name_only do
      enumerable
      |> Stream.map(fn _x -> file_name <> "\n" end)
      |> Stream.dedup()
    else
      enumerable
    end
  end

  @spec match_return(String.t(), Regex.t(), boolean()) :: String.t()
  defp match_return(line, regex, invert) do
    match = Regex.match?(regex, line)
    if (match && !invert) || (!match && invert) do
      line
    else
      ""
    end
  end
end
