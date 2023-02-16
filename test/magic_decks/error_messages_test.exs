defmodule MagicDecks.ErrorMessagesTest do
  use ExUnit.Case
  alias MagicDecks.ErrorMessages

  describe "invalid_uuid_format/0" do
    test "returns default invalid uuid format error message" do
      assert ErrorMessages.invalid_uuid_error() == "Invalid id format."
    end
  end
end
