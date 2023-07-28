FactoryBot.define do
  factory :subscription do
    association :customer
    association :tea
    title { Faker::Tea.variety }
    price { Faker::Number.decimal(l_digits: 2) }
    status { "active" }
    frequency { "weekly" }
  end
end