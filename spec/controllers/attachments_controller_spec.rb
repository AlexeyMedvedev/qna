require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let!(:question) { create(:question) }

  describe "DELETE #destroy" do
    let(:user){ create(:user)}
    let!(:answer) { create(:answer, question: question, user: user) }
    let!(:attachment) { create(:attachment, attachmentable: answer)}

    it 'deleted attachment by user created' do
      sign_in(user)
      expect {delete :destroy, id: attachment, format: :js}.to change(Attachment, :count).by(-1)  
    end

    it 'not deleted answer by another user created' do
      anuser = create(:user)
      sign_in(anuser)
      expect {delete :destroy, id: attachment, format: :js}.to change(Attachment, :count).by(0)  
    end

  end
end