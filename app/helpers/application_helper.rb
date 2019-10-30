module ApplicationHelper
  def get_user(user_id)
    User.find_by(id: user_id)
  end

  def getter_show_in_list_questions
    Question.where(show_in_list: true)
      .includes(:answers).page(params[:page]).per(3)
  end
end
