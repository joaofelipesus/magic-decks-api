defmodule MagicDecks.CardTest do
  use MagicDecks.DataCase
  alias MagicDecks.Card
  import MagicDecks.Factory

  describe "changeset/1" do
    test "returns an valid changeset, when params are valid" do
      result =
        build(:card_params)
        |> Card.changeset()

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
                 types: ["creature"],
                 image_url: "http://example.com/image.jpg",
               },
               errors: [],
               data: %Card{},
               valid?: true
             } = result
    end

    test "returns an invalid changeset, when params has errors" do
      result =
        build(:card_params, %{name_pt: nil})
        |> Card.changeset()

      assert %Ecto.Changeset{
               valid?: false,
               errors: [name_pt: {"can't be blank", [validation: :required]}],
               data: %Card{}
             } = result
    end
  end

  describe "changeset/2" do
    test "returns an valid changeset, when params are valid" do
      {:ok, card} =
        build(:card_params, %{power: 5})
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
      {:ok, card} =
        build(:card_params)
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

  test "validates external_id uniqueness" do
    uuid = "2882e3b0-8e9b-426d-8c08-028e28ed284a"

    insert(:card, %{ external_id: uuid})

    card_params = build(:card_params, %{external_id: uuid})

    {:error, result} = MagicDecks.create_card(card_params)

    assert %Ecto.Changeset{
      errors: [
        external_id: {"has already been taken",
         [constraint: :unique, constraint_name: "cards_external_id_index"]}
      ],
      valid?: false
    } = result
  end
end
