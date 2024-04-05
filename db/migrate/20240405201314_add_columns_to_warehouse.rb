class AddColumnsToWarehouse < ActiveRecord::Migration[7.1]
  def change
    add_column :warehouses, :adress, :string
    add_column :warehouses, :zip, :string
    add_column :warehouses, :description, :string
  end
end

