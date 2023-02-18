defmodule MagicDecks.DeckTest do
  use MagicDecks.DataCase
  alias MagicDecks.Deck

  describe "changeset/1" do
    test "returns a valid changeset, when params are valid" do
      params = %{
        name: "Fractius aggro",
        format: :commander,
        description: "Winning matches and loosing friends"
      }

      result = Deck.changeset(params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{
                 description: "Winning matches and loosing friends",
                 format: :commander,
                 name: "Fractius aggro"
               },
               errors: [],
               data: %Deck{},
               valid?: true
             } = result
    end

    test "returns an invalid changeset, when params are invalid" do
      params = %{
        name: "Fractius aggro",
        description: "Winning matches and loosing friends"
      }

      result = Deck.changeset(params)

      assert %Ecto.Changeset{
               action: nil,
               changes: %{
                 description: "Winning matches and loosing friends",
                 name: "Fractius aggro"
               },
               errors: [format: {"can't be blank", [validation: :required]}],
               data: %Deck{},
               valid?: false
             } = result
    end

    test "validates duplicated name and format" do
      params = %{name: "Fractius aggro", format: :commander}

      params
      |> Deck.changeset()
      |> MagicDecks.Repo.insert()

      {:error, result} =
        params
        |> Deck.changeset()
        |> MagicDecks.Repo.insert()

      assert %Ecto.Changeset{valid?: false} = result
      assert errors_on(result) == %{name: ["has already been taken"]}
    end
  end

  describe "changeset/2" do
    test "returns valid changeset, when params are valid" do
      {:ok, deck} =
        %{name: "Fractius aggro", format: :commander}
        |> Deck.changeset()
        |> MagicDecks.Repo.insert()

      result = Deck.changeset(deck, %{name: "Goblins aggro", format: :modern})

      assert %Ecto.Changeset{
               action: nil,
               changes: %{format: :modern, name: "Goblins aggro"},
               errors: [],
               data: %Deck{},
               valid?: true
             } = result
    end

    test "returns an invalid changeset, when params has errors" do
      {:ok, deck} =
        %{name: "Fractius aggro", format: :commander}
        |> Deck.changeset()
        |> MagicDecks.Repo.insert()

      result = Deck.changeset(deck, %{name: "Goblins aggro", format: :yolo})

      assert %Ecto.Changeset{valid?: false} = result
      assert errors_on(result) == %{format: ["is invalid"]}
    end
  end
end
