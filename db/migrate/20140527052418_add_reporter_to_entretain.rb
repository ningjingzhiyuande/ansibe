class AddReporterToEntretain < ActiveRecord::Migration
  def change
  	add_column :entretains, :last_reporter_id, :integer 
  end
end
