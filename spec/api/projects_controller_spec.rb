require 'rails_helper'

describe ProjectsController do
  context '#index' do
    it 'returns an array with the existing projects' do
      create(:project)
      get '/api/projects'

      expect(status).to eq 200
      expect(parsed_body.count).to eq 1

      project = parsed_body.first
      expected_keys = %w[
        code
        name
        status
        url
        start_date
        end_date
        short
        description
        topics
      ]
      expect(project.keys).to eq expected_keys
    end
  end
end
