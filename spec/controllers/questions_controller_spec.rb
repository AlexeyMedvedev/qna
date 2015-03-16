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
end
