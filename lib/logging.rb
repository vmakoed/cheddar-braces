# frozen_string_literal: true

module Logging
  def log_balanced(source:)
    puts "String \"#{source}\" is balanced!"
  end
  module_function :log_balanced

  def log_imbalanced(source:, issue:, smart_character:)
    puts "String \"#{source}\" is not balanced! Found issue: #{issue} #{smart_character} at index #{smart_character.index}"
  end
  module_function :log_imbalanced
end
