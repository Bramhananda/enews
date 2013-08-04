class Multimedium < ActiveRecord::Base
  belongs_to :picture
  belongs_to :article
  belongs_to :category
end