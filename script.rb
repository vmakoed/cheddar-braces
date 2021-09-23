# frozen_string_literal: true

BRACKETS = {
  '(' => ')',
  '[' => ']'
}.freeze

def balanced_array?(characters)
  first_special = characters.find { |character| BRACKETS.keys.include?(character) }
  first_closing_special = characters.find { |character| BRACKETS.values.include?(character) }

  if first_special.nil?
    return true if first_closing_special.nil?
    return false unless first_closing_special.nil?
  end

  first_index = characters.index(first_special)
  first_closing_special_index = characters.index(first_closing_special)
  return false if !first_closing_special_index.nil? && first_closing_special_index < first_index

  closing_target = BRACKETS[first_special]
  special_closing = characters.reverse.find { |character| BRACKETS.values.include?(character) }
  return false if special_closing.nil? || special_closing != closing_target

  closing_index = characters.reverse.index(special_closing)
  characters.delete_at(first_index)
  characters.delete_at(closing_index - 1)

  balanced_array?(characters)
end

def balanced?(source)
  balanced_array?(source.split(''))
end

p balanced?('()')
p balanced?('(()')
p balanced?('([)]')
p balanced?('[()]')

p balanced?('') # true
p balanced?('(') # false
p balanced?(']') # false
p balanced?('(([[(())]]))') # true
