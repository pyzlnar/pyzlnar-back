# Factory for users
FactoryGirl.define do
  factory :user do
    username  'user'
    email     'user@a.com'
    thumbnail 'image.url'
  end

  factory :admin, class: User do
    username 'admin'
    email    'admin@a.com'
    role     'admin'
  end
end
