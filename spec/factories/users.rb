# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "Rob Bennett" }
    email { 'foo@bar.com' }
    password { 'foobar' }
  end
end