module AnswersHelper
  def get_question(question_id)
    Question.find_by(id: question_id)
  end

  def possesive(name)
    name + ('s' == name[-1,1] ? "' " : "'s ")
  end
end
