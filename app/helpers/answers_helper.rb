module AnswersHelper
  def get_question(question_id)
    Question.find_by(id: question_id)
  end
end
