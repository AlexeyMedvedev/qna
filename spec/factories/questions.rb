FactoryGirl.define do
  factory :question do
  	sequence (:topic) { |n| "MyTopic #{n}"}
    sequence (:text) { |n| "MyText #{n}"  }  
  end
  factory :invalid_question, class: "Question" do
    title nil
    text nil
  end
end
