class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: %i[edit create update destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/new
  def new
    if policy(:application).show?
      redirect_to questions_url(open: true)
    else
      redirect_to questions_url, notice: 'Access denied.'
    end
  end

  # GET /questions/1/edit
  def edit
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.js
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    if params[:method].eql?('put')
      update
    else
      @question = Question.new(question_params)

      respond_to do |format|
        if @question.save
          format.html { redirect_to questions_url, notice: 'Question added.' }
        else
          format.html { render :new }
          format.json { render json: @question.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        Answer.where(question_id: @question.id).destroy_all
        format.html { redirect_to questions_url, notice: 'Question edited.' }
      else
        format.json {
          render json: @question.errors,
          status: :unprocessable_entity
        }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question deleted.' }
      format.json { head :no_content }
    end
  end

  # GET /questions/summary
  def summary
    @question = Question.find(params[:question_id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to questions_url, notice: 'Record not found.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id]) if params[:id]
  rescue ActiveRecord::RecordNotFound
    redirect_to questions_url, notice: 'Record not found.'
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def question_params
    params.permit(:id, :question, :answer_type, :show_in_list, choices: [])
  end
end
