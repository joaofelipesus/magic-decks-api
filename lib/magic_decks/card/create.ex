defmodule MagicDecks.Card.Create do
  alias MagicDecks.{Card, Repo}

  def call(params) do
    params
    |> Card.changeset()
    |> Repo.insert()
  end
end
