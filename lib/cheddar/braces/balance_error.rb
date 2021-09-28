# frozen_string_literal: true

module Cheddar
  module Braces
    # Error message for imbalanced string
    class BalanceError
      attr_reader :issue, :smart_character

      def initialize(issue:, smart_character:)
        @issue = issue
        @smart_character = smart_character
      end

      def to_s
        "#{issue} #{smart_character} at index #{smart_character.index}"
      end
    end
  end
end
