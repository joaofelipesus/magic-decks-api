defmodule MagicDecks.Deck.Update do
  alias MagicDecks.{Deck, Repo}

  def call(params) do
    case Deck.Find.call(params[:id]) do
      {:error, error} -> {:error, error}
      {:ok, deck} -> update_deck(deck, params)
    end
  end

  defp update_deck(deck, params) do
    deck
    |> Deck.changeset(params)
    |> Repo.update()
  end
end
