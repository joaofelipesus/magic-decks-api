defmodule MagicDecks.DeckCard.CreateTest do
  use MagicDecks.DataCase

  import MagicDecks.Factory

  describe "#call" do
    test "creates a new card and a new deck_card register, when card doesn't exist" do
      deck = insert(:deck)

      params = %{
        card: build(:card_params),
        deck_id: deck.id
      }

      before_count = MagicDecks.Repo.aggregate(MagicDecks.Card, :count)

      {:ok, result} = MagicDecks.DeckCard.Create.call(params)

      after_count = MagicDecks.Repo.aggregate(MagicDecks.Card, :count)

      assert after_count > before_count
      assert result.deck_id == deck.id
      assert result.quantity == 1
    end

    test "creates a new deck_card register, when deck don't have received card" do
      card_params = build(:card_params)
      MagicDecks.create_card(card_params)

      deck = insert(:deck)

      params = %{
        card: card_params,
        deck_id: deck.id
      }

      before_count = MagicDecks.Repo.aggregate(MagicDecks.Card, :count)

      {:ok, result} = MagicDecks.DeckCard.Create.call(params)

      after_count = MagicDecks.Repo.aggregate(MagicDecks.Card, :count)

      assert after_count == before_count
      assert result.deck_id == deck.id
      assert result.quantity == 1
    end

    test "increases quantity count, when deck already have received card" do
      card_params = build(:card_params)
      {:ok, card} = MagicDecks.create_card(card_params)

      deck = insert(:deck)

      insert(:deck_card, %{card: card, deck: deck})

      params = %{
        card: card_params,
        deck_id: deck.id
      }

      card_before_count = MagicDecks.Repo.aggregate(MagicDecks.Card, :count)
      deck_card_before_count = MagicDecks.Repo.aggregate(MagicDecks.DeckCard, :count)

      {:ok, result} = MagicDecks.DeckCard.Create.call(params)

      card_after_count = MagicDecks.Repo.aggregate(MagicDecks.Card, :count)
      deck_card_after_count = MagicDecks.Repo.aggregate(MagicDecks.DeckCard, :count)

      assert card_after_count == card_before_count
      assert deck_card_after_count == deck_card_before_count
      assert result.quantity == 2
    end
  end
end
