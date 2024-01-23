FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "UserNr#{n}" }
    sequence(:email) { |i| "user@somewhere#{i}.com" }
  end
end
