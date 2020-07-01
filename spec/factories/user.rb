FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    name {'bot name'}
    password { 'test123' }
    password_confirmation { 'test123' }
  end
end
