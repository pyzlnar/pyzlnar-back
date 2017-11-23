require 'rails_helper'

describe SitesController do
  before { sign_in(build(:admin)) }

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

  context 'POST #create' do
    it 'creates the site and returns 201 with the new site' do
      site = build(:site)
      post '/api/sites', params: { site: site.as_json }

      expect(status).to eq 201
      expect(Site.count).to eq 1
      expect(body).to eq site.to_json
    end

    it 'returns a 422 if the site could not be saved' do
      post '/api/sites'
      expect(status).to eq 422

      site = build(:site, code: nil)
      post '/api/sites', params: { site: site.as_json }
      site.valid?

      expect(status).to eq 422
      expect(Site.count).to eq 0
      expect(body).to eq site.errors.to_json
    end
  end

  context 'PATCH #update' do
    it 'updates the site, returns a 200 with the new site' do
      site = create(:site)

      patch "/api/sites/#{site.code}", params: { site: { code: :newcode } }
      site.reload

      expect(status).to eq 200
      expect(body).to eq site.to_json
    end

    it 'returns a 404 if the site is not found' do
      site = build(:site)
      patch "/api/sites/#{site.code}"
      expect(status).to eq 404
    end

    it 'returns a 422 if the site could not be saved' do
      site = create(:site)
      patch "/api/sites/#{site.code}", params: { site: { code: nil } }
      expect(status).to eq 422

      expect(site.code).to eq Site.first.code
    end
  end

  context 'DELETE #destroy' do
    it 'destroys the site, returns a 204' do
      site = create(:site)

      delete "/api/sites/#{site.code}"

      expect(status).to eq 204
      expect(Site.count).to eq 0
    end

    it 'returns a 404 if the site is not found' do
      site = build(:site)
      delete "/api/sites/#{site.code}"
      expect(status).to eq 404
    end
  end
end
