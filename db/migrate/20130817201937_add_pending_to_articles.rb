class AddPendingToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :pending, :boolean, default: false
  end
end
