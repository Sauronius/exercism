defmodule Darts do
  @type position :: {number, number}
  defguardp mid(x, y) when x * x + y * y <= 25
  defguardp inner(x, y) when x * x + y * y <= 1
  defguardp outer(x, y) when x * x + y * y <= 100
  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) when inner(x, y), do: 10
  def score({x, y}) when mid(x, y), do: 5
  def score({x, y}) when outer(x, y), do: 1
  def score({_x, _y}), do: 0
end
