defmodule MagicDecks do
  defdelegate create_deck(params), to: MagicDecks.Deck.Create, as: :call
  defdelegate find_deck(params), to: MagicDecks.Deck.Find, as: :call
end
