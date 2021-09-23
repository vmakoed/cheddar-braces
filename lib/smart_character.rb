# frozen_string_literal: true

class SmartCharacter
  SPECIALS = {
    '(' => ')',
    '[' => ']'
  }.freeze

  attr_reader :source, :index

  def initialize(source, index)
    @source = source
    @index = index
  end

  def opening?
    SPECIALS.keys.include?(source)
  end

  def closing?
    SPECIALS.values.include?(source)
  end

  def before?(smart_character)
    index < smart_character.index
  end

  def matches?(smart_character)
    SPECIALS[source] == smart_character.source
  end

  def empty!
    @source = ' '
  end

  def to_s
    source
  end
end
