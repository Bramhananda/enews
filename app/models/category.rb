class Category < ActiveRecord::Base
 acts_as_nested_set
  attr_accessible :title, :parent_id
  has_many :articles

  validates :title, presence: true

  def self.list
      where.not(title: ENV['UNCATEGORIZED'].dup)
  end

  def self.uncategorized
      find_by(title: ENV['UNCATEGORIZED'].dup)
  end

end
