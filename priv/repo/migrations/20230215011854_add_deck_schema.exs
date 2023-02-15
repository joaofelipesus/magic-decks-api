defmodule MagicDecks.Repo.Migrations.AddDeckSchema do
  use Ecto.Migration

  def change do
    create table(:decks, primary_key: false) do
      add :id, :uuid, primary_key: true
      timestamps()
      add :name, :string
      add :format, :string
      add :description, :string
    end

    create unique_index(:decks, [:name, :format], name: :decks_unique_name_and_format_index)
  end
end
