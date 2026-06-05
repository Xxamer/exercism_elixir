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
    def eat(
          %LoafOfBread{},
          %Character{health: health} = character
        ) do
      new_health = health + 5
      {nil, %Character{character | health: new_health}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(
          %ManaPotion{strength: strength},
          %Character{mana: mana} = character
        ) do
      new_mana = mana + strength
      {%EmptyBottle{}, %Character{character | mana: new_mana}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_item, character) do
      {%EmptyBottle{}, %{character | health: 0}}
    end
  end
end
