defmodule MagicDecks.Repo.Migrations.CreateDeckCards do
  use Ecto.Migration

  def change do
    create table(:deck_cards, primary_key: false) do
      add :id, :uuid, primary_key: true

      timestamps()
      add :quantity, :integer

      add :card_id, references(:cards, type: :uuid, on_delete: :delete_all), null: false
      add :deck_id, references(:decks, type: :uuid, on_delete: :delete_all), null: false
    end
  end
end
