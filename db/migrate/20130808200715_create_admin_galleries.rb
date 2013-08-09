class CreateAdminGalleries < ActiveRecord::Migration
  def change
    create_table :admin_galleries do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
