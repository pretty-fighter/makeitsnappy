class QuestionsController < ApplicationController
  before_filter :auth, only: [:create, :your_questions, :edit, :update]

  def index
  	@question = Question.new
    @questions = Question.unsolved(params)
  end

  def create
  	@question = current_user.questions.build(question_create_params)
  	if @question.save
      flash[:success] = 'Your question has been posted!'
      redirect_to @question
  	else
      @questions = Question.unsolved(params)
      render 'index'
  	end
  end

  def show
    @question = Question.find(params[:id])
  end

  def your_questions
    @questions = current_user.your_questions(params)
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_update_params)
      flash[:success] = 'Your question has been updated'
      redirect_to @question
    else
      render 'edit'
    end
  end

  private

  def question_create_params
    params.require(:question).permit(:body)
  end

  def question_update_params
    params.require(:question).permit(:body, :solved)
  end
end
