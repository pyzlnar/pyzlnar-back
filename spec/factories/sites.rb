# Factory for sites
FactoryGirl.define do
  factory :site do
    code   'mysite'
    name   'My Super Site'
    status 'active'
    url    'http://site.dev'
    description  'A very long description'
    topics %w[personal]
  end
end
