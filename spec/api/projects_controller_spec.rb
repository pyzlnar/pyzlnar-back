require 'rails_helper'

describe ProjectsController do
  before { sign_in(build(:admin)) }

  context 'GET #index' do
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

  context 'POST #create' do
    it 'creates the project and returns 201 with the new project' do
      project = build(:project)
      post '/api/projects', params: { project: project.as_json }

      expect(status).to eq 201
      expect(Project.count).to eq 1
      expect(body).to eq project.to_json
    end

    it 'returns a 422 if the project could not be saved' do
      post '/api/projects'
      expect(status).to eq 422

      project = build(:project, code: nil)
      post '/api/projects', params: { project: project.as_json }
      project.valid?

      expect(status).to eq 422
      expect(Project.count).to eq 0
      expect(body).to eq project.errors.to_json
    end
  end

  context 'PATCH #update' do
    it 'updates the project, returns a 200 with the new project' do
      project = create(:project)

      patch "/api/projects/#{project.code}", params: { project: { code: :newcode } }
      project.reload

      expect(status).to eq 200
      expect(body).to eq project.to_json
    end

    it 'returns a 404 if the project is not found' do
      project = build(:project)
      patch "/api/projects/#{project.code}"
      expect(status).to eq 404
    end

    it 'returns a 422 if the project could not be saved' do
      project = create(:project)
      patch "/api/projects/#{project.code}", params: { project: { code: nil } }
      expect(status).to eq 422

      expect(project.code).to eq Project.first.code
    end
  end

  context 'DELETE #destroy' do
    it 'destroys the project, returns a 204' do
      project = create(:project)

      delete "/api/projects/#{project.code}"

      expect(status).to eq 204
      expect(Project.count).to eq 0
    end

    it 'returns a 404 if the project is not found' do
      project = build(:project)
      delete "/api/projects/#{project.code}"
      expect(status).to eq 404
    end
  end
end
