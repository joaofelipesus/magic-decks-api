defmodule MagicDecksWeb.DecksViewTest do
  use MagicDecksWeb.ConnCase

  import Phoenix.View

  describe "show/2" do
    test "returns a parsed deck" do
      {:ok, deck} =
        %{name: "Fractius aggro", format: :standard, description: "Deck forfun"}
        |> MagicDecks.create_deck()

      result = render(MagicDecksWeb.DecksView, "show.json", %{deck: deck})

      assert %{
        description: "Deck forfun",
        format: :standard,
        id: _id,
        inserted_at: _inserted_at,
        name: "Fractius aggro"
      } = result
    end
  end
end
