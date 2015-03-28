require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #new' do
    sign_in_user
    before do
    	question = FactoryGirl.create(:question)
    	get :new, question_id: question
    end

    it 'set answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    let(:question) { create(:question) }
    context 'valid attr' do
      it 'save new answer' do
        expect {post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)      end
      
      it 'redirect to show' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    context 'invalid attr' do
      it 'does not save the answer' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }
               .to_not change(Answer, :count)
      end

      it 'to new view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
   
    end 
  end
end
