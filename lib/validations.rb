# frozen_string_literal

module Validations
  def no_specials?(opening, closing)
    return false unless [opening, closing].all?(&:nil?)

    log_balanced
    true
  end

  def only_opening?(opening, closing)
    return false if opening.nil?
    return false unless closing.nil?

    log_imbalanced('unclosed', opening)
    true
  end

  def only_closing?(opening, closing)
    return false if closing.nil?
    return false unless opening.nil?

    log_imbalanced('unopened', closing)
    true
  end

  def closing_before_opening?(opening, closing)
    return false unless closing.before?(opening)

    log_imbalanced('unopened', closing)
    true
  end

  def opening_does_not_match_reverse_closing?(opening, reverse_closing)
    return false if opening.matches?(reverse_closing)

    log_imbalanced('unclosed', opening)
    true
  end

  def log_balanced
    puts "String \"#{source}\" is balanced!"
  end

  def log_imbalanced(issue, smart_character)
    puts "String \"#{source}\" is not balanced! "\
      "Found issue: #{issue} #{smart_character} at index #{smart_character.index}"
  end
end
