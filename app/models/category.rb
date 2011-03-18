class Category < ActiveRecord::Base
  acts_as_nested_set
  has_friendly_id :name, :use_slug => true, :cache_column => 'link',:approximate_ascii => true, :ascii_approximation_options => :german
  
  has_many :pages
    
  def children_by_position
    Category.scoped :conditions => { parent_column_name => self }, :order => "position"
  end
  
end
