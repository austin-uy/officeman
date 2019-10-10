module EquipmentHelper
  def get_equipment()
    if policy(:application).show?
      @equipment = Equipment.order(:id).page(params[:page]).per(12)
    else
      @equipment = current_user.equipment.order(:id).page(params[:page]).per(12)
    end
  end

  def get_equipment_status_report()
    @equipment = Equipment.select(:status).group(:status).count(:status)
  end

  def get_equipment_type_report()
    @equipment = Equipment.select(:equipment_type).group(:equipment_type).count(:equipment_type)
  end
end
