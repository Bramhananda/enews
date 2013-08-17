class ChangePendingToActive < ActiveRecord::Migration
  def change
  	remove_column :articles, :pending
  	add_column :articles, :active, :boolean, default: true
  end
end
