# frozen_string_literal: true

require_relative './smart_character'
require_relative './validations'

class SmartString
  include Validations

  attr_reader :source

  def initialize(source)
    @source = source
  end

  def check_balance
    opening = find_opening
    closing = find_closing

    return if no_specials?(opening, closing)
    return if only_opening?(opening, closing)
    return if only_closing?(opening, closing)
    return if closing_before_opening?(opening, closing)

    reverse_closing = find_reverse_closing

    return if opening_does_not_match_reverse_closing?(opening, reverse_closing)

    empty!(opening, reverse_closing)
    check_balance
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
    @characters ||= source.split('').map.with_index do |character, index|
      SmartCharacter.new(character, index)
    end
  end
end
