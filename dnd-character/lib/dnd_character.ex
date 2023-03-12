defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    (score - 10) / 2
    |> :math.floor()
    |> trunc()
  end

  @spec ability :: pos_integer()
  def ability do
    Stream.map(1..4, fn _x -> :rand.uniform(6) end)
    |> Enum.sort()
    |> Enum.slice(1..3)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    jx = struct(DndCharacter, [strength: ability(), dexterity: ability(),
       constitution: ability(), intelligence: ability(), wisdom: ability(),
       charisma: ability(), hitpoints: 10])

    %{jx | hitpoints: jx.hitpoints + modifier(jx.constitution)}
  end
end
