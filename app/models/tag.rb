class Tag < ApplicationRecord
  has_many :taggings
  has_many :blog_post, through: :taggings
  
  validates :slug, uniqueness: true, allow_blank: true
  
  before_validation :generate_slug
  
  def to_s
    name
  end
  
  def to_param
    slug
  end
  
  private
  
  def generate_slug
    return if name.blank?
    
    # Generate slug from name
    self.slug = name.parameterize
    
    # Ensure uniqueness by appending a number if necessary
    original_slug = slug
    counter = 1
    
    while Tag.where(slug: slug).where.not(id: id).exists?
      self.slug = "#{original_slug}-#{counter}"
      counter += 1
    end
  end
end
