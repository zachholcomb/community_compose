FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username {Faker::Internet.username(specifier: 5..8)}
    flat_id {Faker::Number.number(digits: 25)}
  end
end
