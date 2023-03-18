defmodule MagicDecks.DeckCard do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @foreign_key_type Ecto.UUID

  schema "deck_cards" do
    field :quantity, :integer
    belongs_to(:card, MagicDecks.Card)
    belongs_to(:deck, MagicDecks.Deck)

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, [:quantity, :card_id, :deck_id])
    |> validate_required([:quantity, :card_id, :deck_id])
    |> assoc_constraint(:card)
    |> assoc_constraint(:deck)
  end

  def changeset(deck_card, attrs) do
    deck_card
    |> cast(attrs, [:quantity, :card_id, :deck_id])
    |> validate_required([:quantity, :card_id, :deck_id])
    |> assoc_constraint(:card)
    |> assoc_constraint(:deck)
  end
end
