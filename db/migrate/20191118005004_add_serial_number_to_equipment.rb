class AddSerialNumberToEquipment < ActiveRecord::Migration[5.2]
  def change
    add_column :equipment, :serial_number, :text
  end
end
