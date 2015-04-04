require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }

  describe "DELETE destroy" do
    let(:user){ create(:user)}
    let!(:answer) { create(:answer, question: question, user: user) }
    before {sign_in(user)}

    it 'assings the requested answer to @answer' do
      expect {delete :destroy, id: answer, question_id: question, format: :js}.to change(Answer, :count).by(-1)  
    end
  end

  describe 'PATCH #update' do
    let(:user){ create(:user)}
    let(:answer) { create(:answer, question: question, user: user) }
    before {sign_in(user)}

    it 'assings the requested answer to @answer' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns th question' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, id: answer, question_id: question, answer: { text: 'new body'}, format: :js
      answer.reload
      expect(answer.text).to eq 'new body'
    end

    it 'render update template' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end
  end

  describe 'GET #new' do
    let(:user){ create(:user)}
    before {sign_in(user)}
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
    let(:user){ create(:user)}
    before {sign_in(user)}
    context 'valid attr' do
      it 'save new answer' do
        expect {post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(question.answers, :count).by(1)
      end
      
      it 'redirect to show' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js 
        expect(response).to render_template :create
      end
    end
    context 'invalid attr' do
      it 'does not save the answer' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js  }
               .to_not change(Answer, :count)
      end

      it 'to new view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js 
        expect(response).to render_template :create
      end
   
    end 
  end
end
