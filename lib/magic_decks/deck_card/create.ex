defmodule MagicDecks.DeckCard.Create do
  alias MagicDecks.{DeckCard, Repo}

  def call(%{card: %{external_id: external_id}} = params) do
    case Repo.get_by(MagicDecks.Card, external_id: external_id) do
      nil ->
        {:ok, card} = params[:card]
        |> MagicDecks.create_card()

        deck_card_upsert(nil, %{card_id: card.id, deck_id: params[:deck_id]})
      card ->
        Repo.get_by(DeckCard, deck_id: params[:deck_id], card_id: card.id)
        |> deck_card_upsert(%{card_id: card.id, deck_id: params[:deck_id]})
    end
  end

  defp deck_card_upsert(%DeckCard{} = deck_card, _params) do
    quantity = deck_card.quantity + 1

    deck_card
    |> DeckCard.changeset(%{quantity: quantity})
    |> Repo.update()
  end

  defp deck_card_upsert(nil, params) do
    params = Map.put(params, :quantity, 1)

    params
    |> DeckCard.changeset()
    |> Repo.insert()
  end
end
