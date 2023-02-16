defmodule MagicDecks.ErrorMessagesTest do
  use ExUnit.Case
  alias MagicDecks.ErrorMessages

  describe "invalid_uuid_format/0" do
    test "returns default invalid uuid format error message" do
      assert ErrorMessages.invalid_uuid_error() == "Invalid id format."
    end
  end

  describe "resource_not_found/1" do
    test "returns not found error message with capitalized resource name" do
      result = ErrorMessages.resource_not_found(:deck)

      assert "Deck not found." == result
    end
  end
end
