require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
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
  	let(:question) {create(:question)}
    it 'set question to @question' do
      get :show, id: question
      expect(assigns(:question)).to eq question
    end

    it 'render show view' do
      get :show, id: question
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before {get :new}

    it 'set question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
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