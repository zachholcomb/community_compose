FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username(specifier: 5..8) }
    flat_id { Faker::Alphanumeric.alpha(number: 24) }
    zip { Faker::Address.zip }
    about { Faker::Hipster.paragraph }
    interests { 'Hip Hop, Funk, Rock, Ambient'}
    instruments { 'Guitar, Bass, Trombone, Piano'}
  end
end
