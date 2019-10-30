module QuestionsHelper
  def questions(user_id, answered)
    return unless user_id
    answered_questions = get_answered(user_id)
    case answered
    when true
      @questions = Question.where(id: answered_questions).order(:id)
        .page(params[:page_a]).per(3)
    when false
      @questions = Question.where.not(id: answered_questions).order(:id)
        .page(params[:page_u]).per(3)
    when nil
      @questions = Question.order(:id).page(params[:page]).per(3)
    end
  end

  def get_answered(user_id)
    Answer.where(user_id: user_id).pluck(:question_id)
  end

  def get_answer(question_id)
    Answer.find_by(question_id: question_id, user_id: current_user.id)
  end
end
