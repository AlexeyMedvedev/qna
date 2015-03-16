require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe 'GET #index' do
    it 'populate questions array' do
      question1 = FactoryGirl.create(:question)
      question2 = FactoryGirl.create(:question)

      get :index

      expect(assigns(:questions)).to match_array([question1, question2])
    end

    it 'render index view' do
      get :index
      expect(response).to render_template :index
    end
  end
end
