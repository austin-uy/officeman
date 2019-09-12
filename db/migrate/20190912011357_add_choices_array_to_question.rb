class AddChoicesArrayToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :choices, :text, array: true
  end
end
