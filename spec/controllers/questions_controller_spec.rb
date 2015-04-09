require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe 'DELETE #destroy' do
    let(:user){ create(:user)}
    let!(:question) {create(:question, user: user)}

    it 'deleted own question' do
      sign_in(user)
      expect {delete :destroy, id: question}.to change(Question, :count).by(-1)
    end

    it 'not deleted another user question' do
      anuser = create(:user)
      sign_in(anuser)
      expect {delete :destroy, id: question}.to_not change(Question, :count)
    end
  end

  describe 'PATCH #update' do
    let(:user){ create(:user)}
    before {sign_in(user)}
    let(:question) {create(:question)}

    it 'assings the requested question to @question' do
      patch :update, id: question, question: attributes_for(:question), format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes question attributes' do
      patch :update, id: question, question: { topic: 'new topic', text: 'new text'}, format: :js
      question.reload
      expect(question.text).to eq 'new text'
      expect(question.topic).to eq 'new topic'
    end

    it 'render update template' do
      patch :update, id: question, question: attributes_for(:question), format: :js
      expect(response).to render_template :update
    end
  end

  describe 'GET #index' do
  	let(:questions) {create_list(:question, 2)}
  	before do
      #@questions = FactoryGirl.create_list(:question, 2)
      #@questions = create_list(:question, 2)

      get :index
  	end

    it 'populate questions array' do
      #question1 = FactoryGirl.create(:question)
      #question2 = FactoryGirl.create(:question)

      #get :index

      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      #get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before {get :show, id: question}
  	let(:question) {create(:question)}
    
    it 'set question to @question' do
      #get :show, id: question
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer to question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render show view' do
      #get :show, id: question
      expect(response).to render_template :show
    end

    it 'builds new attachment to answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

  end

  describe 'GET #new' do
    let(:user){ create(:user)}
    before {sign_in(user)}
    before {get :new}

    it 'set question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachment to @question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:user){ create(:user)}
    before {sign_in(user)}
  	context 'valid attr' do
      it 'save new question' do
        expect {post :create, question: attributes_for(:question)}.to change(Question, :count).by(1)
      end

      it 'redirect to show' do
      	post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
  	end

    context 'invalid attr' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end



end
