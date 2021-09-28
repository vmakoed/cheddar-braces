# frozen_string_literal: true

require_relative 'validations'

# A wrapper around a String that allows checking whether a string is balanced
class SmartString
  include Validations

  attr_reader :source, :error

  def initialize(source)
    @source = source
    @error = nil
  end

  def balanced?
    opening = find_opening
    closing = find_closing

    return true if no_specials?(opening, closing)
    return false if only_opening?(opening, closing)
    return false if only_closing?(opening, closing)
    return false if closing_before_opening?(opening, closing)

    reverse_closing = find_reverse_closing

    return false if opening_does_not_match_reverse_closing?(opening, reverse_closing)

    empty!(opening, reverse_closing)
    balanced?
  end

  private

  def find_opening
    characters.find(&:opening?)
  end

  def find_closing
    characters.find(&:closing?)
  end

  def find_reverse_closing
    reverse_characters.find(&:closing?)
  end

  def empty!(*unwanted_characters)
    unwanted_characters.each(&:empty!)
  end

  def reverse_characters
    @reverse_characters ||= characters.reverse
  end

  def characters
    @characters ||= source.chars.map.with_index do |character, index|
      SmartCharacter.new(character, index)
    end
  end
end
