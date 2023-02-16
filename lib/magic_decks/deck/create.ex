defmodule MagicDecks.Deck.Create do
  alias MagicDecks.{Deck, Repo}

  def call(params) do
    params
    |> Deck.changeset()
    |> Repo.insert()
  end
end
