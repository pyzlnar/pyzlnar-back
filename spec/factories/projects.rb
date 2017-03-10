# Factory for projects
FactoryGirl.define do
  factory :project do
    code         'myproject'
    name         'My Interesting Project'
    status       'active'
    start_date   '2010-10-10'
    end_date     '2011-11-11'
    url          'http://project.dev'
    short        'This is my project'
    description  'A very long description'
    topics %w[personal]
  end
end
