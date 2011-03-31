class Video < ActiveRecord::Base
  has_many :sources
  accepts_nested_attributes_for :sources, :reject_if => proc { |attributes| attributes['video'].blank? }, :allow_destroy => true
  
  validates_presence_of :title

end