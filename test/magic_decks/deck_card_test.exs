defmodule MagicDecks.DeckCardTest do
  use MagicDecks.DataCase

  alias MagicDecks.DeckCard

  import MagicDecks.Factory

  describe "changeset/2" do
    test "valid changeset" do

      deck = insert(:deck)
      card = insert(:card)

      params = %{quantity: 1, card_id: card.id , deck_id: deck.id}
      changeset = DeckCard.changeset(params)

      assert %Ecto.Changeset{
        changes: %{
          card_id: _card_id,
          deck_id: _deck_id,
          quantity: 1
        },
        valid?: true
      } = changeset
    end

    test "invalid changeset" do
      params = %{quantity: nil, card_id: nil, deck_id: nil}
      result = DeckCard.changeset(params)

      assert %Ecto.Changeset{
        action: nil,
        changes: %{},
        errors: [
          quantity: {"can't be blank", [validation: :required]},
          card_id: {"can't be blank", [validation: :required]},
          deck_id: {"can't be blank", [validation: :required]}
        ],
        data: %MagicDecks.DeckCard{},
        valid?: false
      } = result
    end
  end
end
