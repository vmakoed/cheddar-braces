# frozen_string_literal: true

require 'cheddar/braces'

describe SmartString do
  subject(:check_balance) { instance.balanced? }

  let(:instance) { described_class.new(source) }

  ['()', '[]', '[([(([()]))])]', ''].each do |source|
    context "with #{source} as source" do
      let(:source) { source }

      it { is_expected.to be_truthy }
    end
  end

  {
    '(' => 'unclosed ( at index 0',
    ']' => 'unexpected ] at index 0',
    '(()' => 'unclosed ( at index 1',
    '][' => 'unexpected ] at index 0',
    '([)]"' => 'unclosed ( at index 0'
  }.each do |source, error_message|
    context "with #{source} as source" do
      let(:source) { source }

      it { is_expected.to be_falsey }

      it 'sets balance error' do
        expect { check_balance }.to(
          change(instance, :error).from(nil).to(
            satisfying { |error| error.to_s == error_message }
          )
        )
      end
    end
  end
end
