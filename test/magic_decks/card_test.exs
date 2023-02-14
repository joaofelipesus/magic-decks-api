defmodule MagicDecks.CardTest do
  use MagicDecks.DataCase
  alias MagicDecks.Card

  describe "changeset/1" do
    test "returns an valid changeset, when params are valid" do
      params = %{
        name_pt: "Akroma, Anjo da Ira",
        name_en: "Akroma, Angel of Wrath",
        types: ["creature"],
        set: "legions",
        set_number: 6,
        mana_cost: "6{W}{W}{W}",
        rarity: :rare,
        power: 6,
        toughness: 6
      }

      result = Card.changeset(params)

      assert %Ecto.Changeset{
               changes: %{
                 mana_cost: "6{W}{W}{W}",
                 name_en: "Akroma, Angel of Wrath",
                 name_pt: "Akroma, Anjo da Ira",
                 power: 6,
                 rarity: :rare,
                 set: "legions",
                 set_number: 6,
                 toughness: 6,
                 types: ["creature"]
               },
               errors: [],
               data: %Card{},
               valid?: true
             } = result
    end

    test "returns an invalid changeset, when params has errors" do
      params = %{
        name_en: "Akroma, Angel of Wrath",
        types: ["creature"],
        set: "legions",
        set_number: 6,
        mana_cost: "6{W}{W}{W}",
        rarity: :rare,
        power: 6,
        toughness: 6
      }

      result = Card.changeset(params)

      assert %Ecto.Changeset{
               valid?: false,
               errors: [name_pt: {"can't be blank", [validation: :required]}],
               data: %Card{}
             } = result
    end
  end

  describe "changeset/2" do
    test "returns an valid changeset, when params are valid" do
      params = %{
        name_pt: "Akroma, Anjo da Ira",
        name_en: "Akroma, Angel of Wrath",
        types: ["creature"],
        set: "legions",
        set_number: 6,
        mana_cost: "6{W}{W}{W}",
        rarity: :rare,
        power: 5,
        toughness: 6
      }

      {:ok, card} =
        params
        |> Card.changeset()
        |> MagicDecks.Repo.insert()

      update_params = %{power: 6}

      result = Card.changeset(card, update_params)

      assert %Ecto.Changeset{
               changes: %{
                 power: 6
               },
               data: %Card{},
               valid?: true
             } = result
    end

    test "returns an invalid changeset, when params has erros" do
      params = %{
        name_pt: "Akroma, Anjo da Ira",
        name_en: "Akroma, Angel of Wrath",
        types: ["creature"],
        set: "legions",
        set_number: 6,
        mana_cost: "6{W}{W}{W}",
        rarity: :rare,
        power: 5,
        toughness: 6
      }

      {:ok, card} =
        params
        |> Card.changeset()
        |> MagicDecks.Repo.insert()

      update_params = %{name_pt: nil}

      result = Card.changeset(card, update_params)

      assert %Ecto.Changeset{
               data: %Card{},
               valid?: false,
               errors: [name_pt: {"can't be blank", [validation: :required]}]
             } = result
    end
  end
end
