class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[show edit update destroy]

  # GET /answers
  # GET /answers.json
  def index
    redirect_to questions_url, notice: 'Access denied.'
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
    redirect_to questions_url, notice: 'Access denied.'
  end

  # GET /answers/new
  def new
    redirect_to questions_url, notice: 'Access denied.'
  end

  # GET /answers/1/edit
  def edit
    if(current_user.id.eql?(@answer.user_id))
      respond_to do |format|
        format.js { render action: '../questions/edit_answer' }
      end
    else
      respond_to do |format|
        format.html { redirect_to questions_url, notice: 'Access denied.' }
      end
    end
  end

  # POST /answers
  # POST /answers.json
  def create
    @answer = Answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        format.html {
          redirect_to questions_url,
            notice: 'Answer submit successful.'
        }
      else
        format.html { render :new }
        format.json {
          render json: @answer.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to questions_url, notice: 'Answer edited.' }
      else
        format.json {
          render json: @answer.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Answer deleted.' }
      format.json { head :no_content }
    end
  end

  # GET /summary
  def summary
    @answers = Answer.where(user_id: params[:user_id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to questions_url, notice: 'Record not found.'
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def answer_params
    params.require(:answer).permit(:answer, :question_id, :user_id)
  end
end
