# frozen_string_literal: true

require_relative './smart_character'
require_relative './logging'

class SmartString
  attr_reader :source

  def initialize(source)
    @source = source
  end

  def find_opening
    characters.find(&:opening?)
  end

  def find_closing
    characters.find(&:closing?)
  end

  def find_reverse_closing
    characters.reverse.find(&:closing?)
  end

  def empty!(*unwanted_characters)
    unwanted_characters.each(&:empty!)
  end

  def check_balance
    opening = find_opening
    closing = find_closing

    return log_balanced if [opening, closing].all?(&:nil?)

    unless opening.nil?
      return log_imbalanced('unclosed', opening) if closing.nil?
    end

    unless closing.nil?
      return log_imbalanced('unopened', closing) if opening.nil?
    end

    return log_imbalanced('unopened', closing) if closing.before?(opening)

    reverse_closing = find_reverse_closing
    return log_imbalanced('unclosed', opening) unless opening.matches?(reverse_closing)

    empty!(opening, reverse_closing)
    check_balance
  end

  def log_balanced
    Logging.log_balanced(source: source)
  end

  def log_imbalanced(issue, smart_character)
    Logging.log_imbalanced(
      source: source, issue: issue, smart_character: smart_character
    )
  end

  private

  def characters
    @characters ||= source.split('').map.with_index do |character, index|
      SmartCharacter.new(character, index)
    end
  end
end
