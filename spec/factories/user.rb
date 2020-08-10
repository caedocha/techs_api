FactoryBot.define do
  factory :user, class: User do
    name { 'test_api_user' }
    password { 'password' }
  end
end
