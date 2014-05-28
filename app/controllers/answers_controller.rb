class AnswersController < ApplicationController
  before_filter :auth, only: [:create]

  def create
  	@question = Question.find(params[:question_id])
  	@answer = @question.answers.build(answer_create_params)
  	@answer.user = current_user

  	if @answer.save
  	  flash[:answer] = 'Your answer has been posted.'
  	  redirect_to @question
  	else
  	  @question = Question.find(params[:question_id])
  	  render 'questions/show'
  	end
  end

  private

  def answer_create_params
    params.require(:answer).permit(:body)
  end
end
