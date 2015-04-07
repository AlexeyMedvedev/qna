FactoryGirl.define do
  factory :user do
    sequence (:email) { |n| "user#{n}@fake.ru" }
    password '12345678'
    password_confirmation '12345678'
  end

  factory :anuser, class: "User" do
    sequence (:email) { |n| "anuser#{n}@fake.ru" }
    password '1234567890'
    password_confirmation '1234567890'
  end

end
