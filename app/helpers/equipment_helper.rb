module EquipmentHelper
  def get_equipment(user_id)
    return nil unless user_id
    if policy(:application).show?
      @equipment = Equipment.order(:id).page(params[:page]).per(12)
    else
      @equipment = Equipment.where(user_id: user_id).order(:id).page(params[:page]).per(12)
    end
  end

  def get_equipment_status_report()
    @equipment = Equipment.select(:status).group(:status).count(:status)
  end

  def get_equipment_type_report()
    @equipment = Equipment.select(:equipment_type).group(:equipment_type).count(:equipment_type)
  end
end
