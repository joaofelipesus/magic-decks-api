defmodule MagicDecks do
  defdelegate create_deck(params), to: MagicDecks.Deck.Create, as: :call
end
