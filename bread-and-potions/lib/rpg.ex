defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    @spec eat(LoafOfBread.__struct__, Character.__struct__) :: tuple()
    def eat(_loafofbread, character), do: {nil, Map.update!(character, :health, &(&1 + 5))}
  end

  defimpl Edible, for: ManaPotion do
    @spec eat(ManaPotion.__struct__, Character.__struct__) :: tuple()
    def eat(manapotion, character), do:
    {%EmptyBottle{}, Map.update!(character, :mana, &(&1 + Map.get(manapotion, :strength)))}
  end

  defimpl Edible, for: Poison do
    @spec eat(Poison.__struct__, Character.__struct__) :: tuple()
    def eat(_poison, character), do: {%EmptyBottle{}, %{character | health: 0}}
  end
end
