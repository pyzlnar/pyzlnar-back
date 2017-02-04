require 'rails_helper'

describe Site do
  context '#as_json' do
    it 'returns a hash ready to be converted to a public json' do
      site = build(:site)
      expected = {
        code:        site.code,
        name:        site.name,
        status:      site.status,
        url:         site.url,
        description: site.description,
        topics:      site.topics
      }
      expect(site.as_json).to eq expected
    end
  end
end
