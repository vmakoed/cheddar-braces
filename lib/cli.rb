# frozen_string_literal: true

require_relative 'smart_string'

class CLI
  def self.run(args = ARGV)
    args.each do |source|
      SmartString.new(source).check_balance
    end
  end
end
