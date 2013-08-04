class CreateMultimedia < ActiveRecord::Migration
  def change
    create_table :multimedia do |t|
      t.belongs_to :picture
      t.belongs_to :article
      t.belongs_to :category
    end
  end
end
