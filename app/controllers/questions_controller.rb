class QuestionsController < ApplicationController

	def new
      @question = Question.new
	end

	def create
      @question = Question.create(question_params)
      if @question.save
        flash[:notice] = 'Your question successfully created.'
        redirect_to @question
      else
        render :new
      end
 	end

	def index
      @questions = Question.all
	end

	def show
      @question = Question.find(params[:id])
	end

private

    def question_params
      params.require(:question).permit(:topic, :text)
    end
end