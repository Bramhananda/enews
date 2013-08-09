class AddGalleryToMultimedia < ActiveRecord::Migration
  def change
  	add_column :multimedia, :gallery_id, :integer
  	add_index :multimedia, :gallery_id
  end
end
