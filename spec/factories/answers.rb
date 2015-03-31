FactoryGirl.define do
  factory :answer do
    sequence (:text) { |n| "Answer no.#{n}" }
    question
  end
  factory :invalid_answer, class: "Answer" do
    text nil
    question
  end
end
