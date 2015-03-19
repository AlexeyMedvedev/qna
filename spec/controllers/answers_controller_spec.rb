require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe "GET #new" do
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
end
