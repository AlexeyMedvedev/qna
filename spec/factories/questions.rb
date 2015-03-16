FactoryGirl.define do
  factory :question do
  	topic "MyTopic"
    text "MyText"    
  end
  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
