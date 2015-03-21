FactoryGirl.define do
  factory :answer do
    text "AnswerText"
    question
  end
  factory :invalid_answer, class: "Answer" do
    text nil
    question
  end
end
