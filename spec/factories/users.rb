# Factory for users
FactoryGirl.define do
  factory :user do
    email     'user@a.com'
    sub       '9126155545788761'
    thumbnail 'image.url'
    uuid      '81a8eed7-1c47-40be-bf5b-a4fb123cd077'
    username  'user'
  end

  factory :admin, class: User do
    email    'admin@a.com'
    sub      '879051392560642'
    role     'admin'
    uuid     '9600ceec-ea96-4032-9e4a-122eadbb8b63'
    username 'admin'
  end
end
