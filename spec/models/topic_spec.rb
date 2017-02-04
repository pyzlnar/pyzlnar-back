require 'rails_helper'

describe Topic do
  context '.topics' do
    it 'returns an array with the stringified topics' do
      expect(Topic.topics).to eq Topic::TOPICS.map(&:to_s)
    end
  end
end
