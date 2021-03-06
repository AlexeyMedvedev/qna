require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:question) { create(:question) }

  describe "POST #accept" do
    let(:user){ create(:user)}
    let(:answer) { create(:answer, question: question, user: user) }

    it 'accept able to author' do
      sign_in(user)
      expect { post :accept, question_id: question, id: answer, format: :js}.to change { answer.reload.accepted }.from(false).to(true)
    end

    it 'accept unable to another user' do
      anuser = create(:user)
      sign_in(anuser)
      expect { post :accept, question_id: question, id: answer, format: :js}.to_not change { answer.reload.accepted }
    end

  end

  describe "DELETE #destroy" do
    let(:user){ create(:user)}
    let!(:answer) { create(:answer, question: question, user: user) }

    it 'deleted answer by user created' do
      sign_in(user)
      expect {delete :destroy, id: answer, question_id: question, format: :js}.to change(Answer, :count).by(-1)  
    end

    it 'not deleted answer by another user created' do
      anuser = create(:user)
      sign_in(anuser)
      expect {delete :destroy, id: answer, question_id: question, format: :js}.to change(Answer, :count).by(0)  
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
