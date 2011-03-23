require 'active_record/transitions'

class Page < ActiveRecord::Base
  include ActiveRecord::Transitions
  
  belongs_to :category
  
  validates_presence_of :title
  has_friendly_id :title, :use_slug => true, :cache_column => 'link',:approximate_ascii => true, :ascii_approximation_options => :german
  
  state_machine do
    state :draft
    state :published
    state :archived
    
    event :publish do
      transitions :to => :published, :from => [:draft, :archived], :on_transition => :set_published_at
    end
    
    event :unpublish do
      transitions :to => :draft, :from => :published, :on_transition => :unset_published_at
    end
    
    event :archive do
      transitions :to => :archived, :from => [:draft, :published], :on_transition => :set_archived_at
    end
    
    event :unarchive do
      transitions :to => :draft, :from => :archived, :on_transition => :unset_archived_at
    end
  end
  
  def available_events
    Page.state_machines[:default].events_for(self.state.to_sym)
  end
    
  
  protected
  
  before_save :transform
  
  def transform
    self.content_html = textilize self.content
  end
  
  def set_published_at
    self.archived_at = nil
    self.published_at = Time.now
  end
  
  def unset_published_at
    self.published_at = nil
  end
  
  def set_archived_at
    self.archived_at = Time.now
    self.published_at = nil
  end
  
  def unset_archived_at
    self.archived_at = nil
  end
  
end
