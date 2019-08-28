# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { 'foo@bar.com' }
    password { 'foobar' }
  end
end