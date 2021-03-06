module EquipmentHelper
  def getter_equipment
    @equipment =
    if policy(:application).show?
      Equipment.order(:id).page(params[:page]).per(12)
    else
      current_user.equipment.order(:id).page(params[:page]).per(12)
    end
  end

  def get_equipment_status_report(type)
    @equipment = Equipment.select(:status).group(:status).count(:status)
    if type.eql?('pie')
      @equipment.each do |key, value|
        @equipment[key] = ((value.to_f / Equipment.all.count.to_f) * 100)
          .round(2)
      end
    end
    @equipment
  end

  def get_equipment_type_report(type)
    @equipment = Equipment.select(:equipment_type).group(:equipment_type)
      .count(:equipment_type)
    if type.eql?('pie')
      @equipment.each do |key, value|
        @equipment[key] = ((value.to_f / Equipment.all.count.to_f) * 100)
          .round(2)
      end
    end
    @equipment
  end
end
