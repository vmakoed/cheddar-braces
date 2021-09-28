# frozen_string_literal: true

module Cheddar
  module Braces
    # A class responsible for command-line interface
    class CLI
      def self.run(args = ARGV)
        args.each do |source|
          check_string_balance(source)
        end
      end

      def self.check_string_balance(source)
        SmartString.new(source).tap do |smart_string|
          if smart_string.balanced?
            puts "String \"#{source}\" is balanced!"
          else
            puts "String \"#{source}\" is not balanced! Found issue: #{smart_string.error}"
          end
        end
      end
    end
  end
end
