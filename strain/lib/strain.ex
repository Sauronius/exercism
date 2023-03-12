defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    keep_ht(list, fun, [])
  end

  defp keep_ht([], _fun, result), do: Enum.reverse(result)

  defp keep_ht([head | tail], fun, result) do
    if fun.(head) == true do
      keep_ht(tail, fun, [head | result])
    else
      keep_ht(tail, fun, result)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    discard_ht(list, fun, [])
  end

  defp discard_ht([], _fun, result), do: Enum.reverse(result)

  defp discard_ht([head | tail], fun, result) do
    if fun.(head) == false do
      discard_ht(tail, fun, [head | result])
    else
      discard_ht(tail, fun, result)
    end
  end
end
