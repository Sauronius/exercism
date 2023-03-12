defmodule BoutiqueSuggestions do
  @spec get_combinations(list(), list(), list()) :: list()
  def get_combinations(tops, bottoms, options \\ [maximum_price: 100.00]) do
    max = Keyword.get(options, :maximum_price, 100.00)
    for i <- tops, j <- bottoms,
        i.base_color != j.base_color and i.price + j.price <= max do
          {i, j}
    end
  end
end
