class AnswersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :get_question
    before_action :get_answer, only: [:edit, :update, :destroy]

	def new
		#@question = Question.find(params[:question_id])
		@answer = @question.answers.new
	end

	def create
	  #@question = Question.find(params[:question_id])
      @answer = @question.answers.new(answers_params)
      if @answer.save
        redirect_to @question
      else
        render :new
      end
   	end

	private

	def get_question
		@question = Question.find(params[:question_id])
	end

  def get_answer
    @answer = @question.answers.find(params[:id])
  end

	def answers_params
      params.require(:answer).permit(:text)
	end 
end
