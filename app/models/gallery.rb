class Gallery < ActiveRecord::Base
	attr_accessible :title, :description, :pictures_attributes
	validates :title, presence: true
	has_many :multimedia
	has_many :pictures, :through=>:multimedia
	has_many :articles, :through=>:multimedia
	accepts_nested_attributes_for :pictures
end