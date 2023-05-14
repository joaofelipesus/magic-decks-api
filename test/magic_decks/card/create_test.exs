defmodule MagicDecks.Card.CreateTest do
  use MagicDecks.DataCase

  alias MagicDecks.Card.Create

  describe "call/1" do
    test "creates a card and returns it, when params are valid" do
      {:ok, card} =
        %{
          image_url: "http://example.com/image.jpg",
          mana_cost: "6{W}{W}{W}",
          name_en: "Akroma, Angel of Wrath",
          name_pt: "Akroma, Anjo da Ira",
          power: 6,
          rarity: :rare,
          set: "legions",
          set_number: 6,
          toughness: 6,
          types: ["creature"],
          external_id: "15c06ada-0869-4b15-94fc-22858c6bd130"
        }
        |> Create.call()

      assert %MagicDecks.Card{
               id: _id,
               image_url: "http://example.com/image.jpg",
               mana_cost: "6{W}{W}{W}",
               name_en: "Akroma, Angel of Wrath",
               name_pt: "Akroma, Anjo da Ira",
               power: 6,
               rarity: :rare,
               set: "legions",
               set_number: 6,
               toughness: 6,
               types: ["creature"],
               external_id: "15c06ada-0869-4b15-94fc-22858c6bd130"
             } = card
    end

    test "returns error, when params are invalid" do
      {:error, result} = Create.call(%{})

      assert %Ecto.Changeset{
               action: :insert,
               errors: [
                 name_en: {"can't be blank", [validation: :required]},
                 set: {"can't be blank", [validation: :required]},
                 set_number: {"can't be blank", [validation: :required]},
                 mana_cost: {"can't be blank", [validation: :required]},
                 types: {"can't be blank", [validation: :required]},
                 rarity: {"can't be blank", [validation: :required]},
                 external_id: {"can't be blank", [validation: :required]}
               ],
               data: %MagicDecks.Card{},
               valid?: false
             } = result
    end
  end
end
