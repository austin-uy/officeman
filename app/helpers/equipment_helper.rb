module EquipmentHelper
  def get_equipment(user_id)
    return nil unless user_id
    if current_user.role.eql? "admin" #admin
      @equipment = Equipment.order(:id).page(params[:page]).per(10)
    else
      @equipment = Equipment.where(user_id: user_id).order(:id).page(params[:page]).per(10)
    end
  end
end
