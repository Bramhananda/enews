class ChangeAdminGallery < ActiveRecord::Migration
  def change
  	rename_table :admin_galleries, :galleries
  end
end
