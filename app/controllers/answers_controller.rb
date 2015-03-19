class AnswersController < ApplicationController
	def new
		@question = Question.find(params[:question_id])
		@answer = @question.answers.new
	end

	def create

	end

	private

	def get_question
		#@question = Question.find(params[:question_id])
	end
end
