defmodule MagicDecks do
  defdelegate create_deck(params), to: MagicDecks.Deck.Create, as: :call
  defdelegate find_deck(params), to: MagicDecks.Deck.Find, as: :call
  defdelegate update_deck(params), to: MagicDecks.Deck.Update, as: :call
  defdelegate delete_deck(params), to: MagicDecks.Deck.Delete, as: :call
  defdelegate list_deck(params), to: MagicDecks.Deck.List, as: :call

  defdelegate create_card(params), to: MagicDecks.Card.Create, as: :call
  defdelegate list_card(), to: MagicDecks.Card.List, as: :call
end
