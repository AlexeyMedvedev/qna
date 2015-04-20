require 'rails_helper'

RSpec.describe Answer, type: :model do
  it {should validate_presence_of(:text)}
  it {should belong_to(:question)}
  it {should belong_to(:user)}

  it {should have_many(:attachments)}
  it {should accept_nested_attributes_for :attachments}


  describe 'accept' do
    let(:user) { create(:user) }
    let(:question) { create(:question, user: user) }
    let(:answer) { create(:answer, user: user, question: question) }

    it 'should assign accept to true' do
      answer.accept
      expect(answer.accepted).to eq true
    end

    it 'should change accept to false' do
      answer2 = create(:answer, user: user, question: question)
      answer2.accept
      answer.accept
      answer.reload
      answer2.reload
      expect(answer.accepted).to eq true
      expect(answer2.accepted).to eq false
    end

  end
end
