defmodule MagicDecks.Repo.Migrations.CreateCardsSchema do
  use Ecto.Migration

  def change do
    create table(:cards, primary_key: false) do
      add :id, :uuid, primary_key: true
      timestamps()
      add :name_en, :string
      add :name_pt, :string
      add :set, :string
      add :set_number, :integer
      add :rarity, :string
      add :mana_cost, :string
      add :types, {:array, :string}
      add :power, :integer
      add :toughness, :integer
      add :colors, {:array, :string}
      add :image_url, :string
    end
  end
end
