class AddFeeToEntretain < ActiveRecord::Migration
  def change
    add_column :entretains, :fee, :string
  end
end
