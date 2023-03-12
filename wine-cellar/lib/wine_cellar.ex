defmodule WineCellar do
  @spec explain_colors() :: Keyword.t()
  def explain_colors do
    [{:white, "Fermented without skin contact."},
     {:red, "Fermented with skin contact using dark-colored grapes."},
     {:rose, "Fermented with some skin contact, but not enough to qualify as a red wine."}]
  end

  @spec filter(Keyword.t(), atom(), Keyword.t()) :: list()
  def filter(cellar, color, opts \\ []) do
    cond do
      Keyword.has_key?(opts, :year) and Keyword.has_key?(opts, :country) ->
        Keyword.get_values(cellar, color)
        |> filter_by_year(Keyword.get(opts, :year))
        |> filter_by_country(Keyword.get(opts, :country))
      Keyword.has_key?(opts, :year) ->
        Keyword.get_values(cellar, color)
        |> filter_by_year(Keyword.get(opts, :year))
      Keyword.has_key?(opts, :country) ->
        Keyword.get_values(cellar, color)
        |> filter_by_country(Keyword.get(opts, :country))
      true ->
        Keyword.get_values(cellar, color)
    end
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
