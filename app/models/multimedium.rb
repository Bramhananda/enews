class Multimedium < ActiveRecord::Base
  belongs_to :picture
  belongs_to :article
  belongs_to :category
  belongs_to :gallery
end