class Article < ActiveRecord::Base
  default_scope ->{ order("created_at DESC")}
 
  before_validation :set_default_category

  acts_as_taggable
  #attr_accessible :title, :content, :publish_date, :category_id, :tag_list, :pictures_attributes, :category, :active

  belongs_to :category
  belongs_to :user
  validates :title, :content, presence: true
  validates :content, length: {minimum: 10}
  validates :category_id, presence: true
  has_many :multimedia
  has_many :pictures, :through=>:multimedia
  has_many :galleries, :through=>:multimedia
  accepts_nested_attributes_for :pictures



def self.trending_ratio
      yesterdays_articles = where("created_at >= ? AND created_at <?", Date.yesterday.beginning_of_day, Date.today.beginning_of_day ).count
  todays_articles = where("created_at >=? ", Date.today.beginning_of_day ).count
  sub = todays_articles.to_f - yesterdays_articles.to_f
  total = sub.to_f / todays_articles.to_f
  result = total *100
  if todays_articles < yesterdays_articles
    down = <<-HTML
     <div class="stat stat-important">#{result.infinite? ? "%0" : "%#{result}"}</div>
    HTML
  elsif  todays_articles == yesterdays_articles
    same = <<-HTML
     <div class="badge">#{result.infinite? ? "%0" : "%#{result}"}</div>
    HTML
  else
   up= <<-HTML
     <div class="stat stat-success">#{result.infinite? ? "%0" : "%#{result}"}</div>
    HTML
  end

end

private

def set_default_category
  self.category = Category.uncategorized if self.category.blank?
end


end
