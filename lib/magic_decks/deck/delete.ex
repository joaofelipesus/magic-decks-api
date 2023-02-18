defmodule MagicDecks.Deck.Delete do
  alias MagicDecks.Repo

  def call(id) do
    case MagicDecks.find_deck(id) do
      {:error, _error} = error -> error
      {:ok, deck} -> delete_deck(deck)
    end
  end

  defp delete_deck(deck), do: Repo.delete(deck)
end
