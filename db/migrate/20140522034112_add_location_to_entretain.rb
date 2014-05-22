class AddLocationToEntretain < ActiveRecord::Migration
  def change
    add_column :entretains, :location, :string
  end
end
