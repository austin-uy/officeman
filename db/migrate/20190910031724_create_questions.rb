class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :question, null: false, default: ""
      t.integer :answer_type
      t.boolean :show_in_list

      t.timestamps
    end
  end
end
