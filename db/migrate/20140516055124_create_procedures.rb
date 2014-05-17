class CreateProcedures < ActiveRecord::Migration
  def change
    create_table :procedures do |t|
      t.integer :user_id
      t.integer :entry_id
      t.string :entry_type
      t.integer :reporter_id
      t.string :aasm_state
      t.integer :position
      t.text    :info
      t.timestamps
    end
  end
end
