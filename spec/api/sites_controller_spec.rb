require 'rails_helper'

describe SitesController do
  context '#index' do
    it 'returns a an array with the existing sites' do
      create(:site)
      get '/api/sites'

      expect(status).to eq 200
      expect(parsed_body.count).to eq 1

      site = parsed_body.first
      expect(site.keys).to eq %w[code name status url description topics]
    end
  end
end
