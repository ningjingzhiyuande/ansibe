class CreateNetCards < ActiveRecord::Migration
  def change
    create_table :net_cards do |t|
      t.integer :applicant_id
      t.string :reviewer1_username
      t.string :reviewer2_username
      t.string :workflow_state
      t.text :request_excuse, comment: '申请3g的理由'
      t.date :start_at
      t.date :end_at
      # t.integer :quantity

      t.timestamps
    end
  end
end
