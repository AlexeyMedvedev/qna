class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def new
      @question = Question.new
      @question.attachments.build
	end

	def create
      @question = Question.new(question_params)
      @question.user = current_user
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
      @answer.attachments.build
	end

  def destroy
    if @question.user_id == current_user.id
      @question.destroy
      flash[:notice] = 'You question successfully deleted.'
    else
      flash[:notice] = 'You cant delete this question.'
    end
    redirect_to questions_path
  end

  def update
    @question = Question.find(params[:id])
    @question.update(question_params)
  end

private

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:topic, :text, attachments_attributes: [:file])
  end
end
