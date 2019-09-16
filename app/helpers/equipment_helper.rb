module EquipmentHelper
  def get_equipment(user_id)
    return nil unless user_id
    @equipment = Equipment.where(user_id: user_id).order(:id).page(params[:page]).per(10)
  end
end
