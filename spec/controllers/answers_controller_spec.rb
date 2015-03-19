require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe 'GET #new' do
    before do
    	question = FactoryGirl.create(:question)
    	get :new, question_id: question.id
    end

    it 'set answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:question) { create(:question) }
    context 'valid attr' do
      it 'save new answer' do
        expect {post :create, question_id: question.id, answer: attributes_for(:answer) }.to change(Answer, :count).by(1)      end
      
      it 'redirect to show' do
        post :create, question_id: question.id, answer: attributes_for(:answer)
        expect(response).to redirect_to question_answers_path(assigns(:question))
      end
    end
    #context 'with invalid attributes' do
    #  it 'does not save the answer' do
    #    expect { post :create, question_id: question.id, answer: attributes_for(:invalid_answer) }
    #           .to_not change(Answer, :count)
    #  end

    #  it 're-renders new view' do
    #    post :create, question_id: question, answer: attributes_for(:invalid_answer)
    #    expect(response).to render_template :new
    #  end
   
    #end 
  end
end
