class Picture < ActiveRecord::Base
  attr_accessible :image
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates :image, :attachment_presence => true
  has_many :multimedia
  has_many :articles, :through=>:multimedia
end
