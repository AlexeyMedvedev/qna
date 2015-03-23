class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def new
      @question = Question.new
	end

	def create
      @question = Question.new(question_params)
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
      #@question = Question.find(params[:id])
      @answer = @question.answers.new
	end

private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:topic, :text)
  end
end
