class BlogPost < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title,   presence: true, length: { maximum: 50 }
  validates :summary, presence: false, length: { maximum: 150 }
  validates :content, presence: true
  validates :slug, uniqueness: true, allow_blank: true
  
  before_validation :generate_slug
  
  def to_param
    slug
  end

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
  
  private
  
  def generate_slug
    return if title.blank?
    
    # Generate slug from title
    self.slug = title.parameterize
    
    # Ensure uniqueness by appending a number if necessary
    original_slug = slug
    counter = 1
    
    while BlogPost.where(slug: slug).where.not(id: id).exists?
      self.slug = "#{original_slug}-#{counter}"
      counter += 1
    end
  end
end
