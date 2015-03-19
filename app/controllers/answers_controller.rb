class AnswersController < ApplicationController
	def new
		@question = Question.find(params[:question_id])
		@answer = @question.answers.new
	end

	def create
	  @question = Question.find(params[:question_id])
      @answer = @question.answers.create(answers_params)
      if @answer.save
        redirect_to question_answers_path(@question)
      else
        render :new
      end
   	end

	private

	def get_question
		#@question = Question.find(params[:question_id])
	end

	def answers_params
      params.require(:answer).permit(:text)
	end 
end