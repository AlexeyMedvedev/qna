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
      @answer.save
      #if @answer.save
        #теперь тут вызывается create.js.erb
        #redirect_to @question
        #redirect_to question_path(@answer.question)
      #else
      #  render :new
      #end
   	end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answers_params)
  end

  def destroy
    if @answer.user_id == current_user.id
      @answer.destroy
      flash[:notice] = 'Answer successfully deleted.'
    else
      flash[:notice] = 'You cant delete this question.'
    end
    redirect_to @answer.question
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
