class Image < ActiveRecord::Base
  include ValidatesAsImage
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :whiny => false
  validates_attachment_presence :image, :message => I18n.t('activerecord.errors.models.image.attributes.image.blank')
  validates_as_image :image
  validates_presence_of :title
  
end
