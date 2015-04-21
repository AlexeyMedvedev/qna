class AnswersController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :get_question
    before_action :get_answer, only: [:edit, :update, :destroy, :accept]

	def new
		#@question = Question.find(params[:question_id])
		@answer = @question.answers.new
	end

	def create
	    #@question = Question.find(params[:question_id])
      @answer = @question.answers.build(answers_params)
      @answer.user = current_user
      #@answer.save

      #if @answer.save
        #теперь тут вызывается create.js.erb
        #redirect_to @question
        #redirect_to question_path(@answer.question)
      #else
      #  render :new
      #end

      respond_to do |format|
        if @answer.save
          format.html { render partial: 'questions/answers', layout: false }
          format.json { render json: @answer}
        else
          format.html { render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity}
          format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity}
        end
      end
   	end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answers_params)
  end

  def destroy
    #binding.pry
    #@answer.destroy
    if @answer.user == current_user
      @answer.destroy
      #  flash[:notice] = 'Answer successfully deleted.'
    #else
      #  flash[:notice] = 'You cant delete this answer.'
    end
    #redirect_to @answer.question
  end

  def accept
    if @answer.user == current_user
      @answer.accept
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
    params.require(:answer).permit(:text, attachments_attributes: [:file])
	end 
end
