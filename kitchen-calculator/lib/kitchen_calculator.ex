defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    # Please implement the get_volume/1 function
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair) do
    # Please implement the to_milliliter/1 functions
    {a, b} = volume_pair
    case a do
      :cup ->
        c = b * 240
        {:milliliter, c}
      :fluid_ounce ->
        c = b * 30
        {:milliliter, c}
      :teaspoon ->
        c = b * 5
        {:milliliter, c}
      :tablespoon ->
        c = b * 15
        {:milliliter, c}
      :milliliter ->
        c = b
        {:milliliter, c}
    end
  end

  def from_milliliter(volume_pair, unit) do
    # Please implement the from_milliliter/2 functions
    {_a, b} = volume_pair
    case unit do
      :cup ->
        c = b / 240
        {unit, c}
      :fluid_ounce ->
        c = b / 30
        {unit, c}
      :teaspoon ->
        c = b / 5
        {unit, c}
      :tablespoon ->
        c = b / 15
        {unit, c}
      :milliliter ->
        c = b
        {unit, c}
    end
  end

  def convert(volume_pair, unit) do
    # Please implement the convert/2 function
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
