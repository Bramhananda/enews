class Picture < ActiveRecord::Base
	before_create :default_title
  #attr_accessible :image, :title
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "150x150>", :absolute_thumb=>"150x150#" }
  #validates :title, presence: true
  validates :image, :attachment_presence => true
  has_many :multimedia
  has_many :articles, :through=>:multimedia
  has_many :galleries, :through=>:multimedia

  private

  def default_title
  	self.title ||= File.basename(image.url, '.*').titleize if image
  end
end
