# frozen_string_literal: true

require_relative 'balance_error'

# Validations and logging for the SmartString
module Validations
  def no_specials?(opening, closing)
    [opening, closing].all?(&:nil?)
  end

  def only_opening?(opening, closing)
    return if opening.nil?
    return unless closing.nil?

    update_error('unclosed', opening)
    true
  end

  def only_closing?(opening, closing)
    return false if closing.nil?
    return false unless opening.nil?

    update_error('unexpected', closing)
    true
  end

  def closing_before_opening?(opening, closing)
    return false unless closing.before?(opening)

    update_error('unexpected', closing)
    true
  end

  def opening_does_not_match_reverse_closing?(opening, reverse_closing)
    return false if opening.matches?(reverse_closing)

    update_error('unclosed', opening)
    true
  end

  def update_error(issue, smart_character)
    @error = Cheddar::Braces::BalanceError.new(issue: issue, smart_character: smart_character)
  end
end
