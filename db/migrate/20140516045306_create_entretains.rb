class CreateEntretains < ActiveRecord::Migration
  def change
    create_table :entretains do |t|
      t.integer :user_id
      t.integer :reporter_id
      t.string :title
      t.string :num
      t.text :content
      t.string :attache
      t.string :aasm_state
      t.timestamps
    end
  end
end
