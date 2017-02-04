require 'rails_helper'

describe Project do
  context '#as_json' do
    it 'returns an ordered hash ready to be converted to a public json' do
      project = build(:project)
      expected = {
        code:        project.code,
        name:        project.name,
        status:      project.status,
        start_date:  project.start_date,
        end_date:    project.end_date,
        url:         project.url,
        short:       project.short,
        description: project.description,
        topics:      project.topics
      }
      expect(project.as_json).to eq expected
    end
  end
end
