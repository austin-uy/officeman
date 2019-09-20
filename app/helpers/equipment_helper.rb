module EquipmentHelper
  def get_equipment(user_id)
    return nil unless user_id
    if policy(:application).show?
      @equipment = Equipment.order(:id).page(params[:page]).per(12)
    else
      @equipment = Equipment.where(user_id: user_id).order(:id).page(params[:page]).per(12)
    end
  end
end
