defmodule MagicDecks.Repo.Migrations.AddExternalIdToCard do
  use Ecto.Migration

  def change do
    alter table("cards") do
      add :external_id, :uuid
    end

    create unique_index(:cards, [:external_id], name: :cards_external_id_index)
  end
end
