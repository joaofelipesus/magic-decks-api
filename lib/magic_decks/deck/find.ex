defmodule MagicDecks.Deck.Find do
  alias Ecto.UUID
  alias MagicDecks.{Deck, ErrorMessages, Repo}

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, ErrorMessages.invalid_uuid_error()}
      {:ok, uuid} -> fetch_deck(uuid)
    end
  end

  defp fetch_deck(uuid) do
    case Repo.get(Deck, uuid) do
      nil -> {:error, %{message: ErrorMessages.resource_not_found(:deck), code: 404}}
      deck -> {:ok, deck}
    end
  end
end
