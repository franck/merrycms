class Source < ActiveRecord::Base
  belongs_to :video
  
  CONTAINER_TYPES = ["mp4", "webm", "theora"]
  
  has_attached_file :video, :styles => { :poster => ['100', :jpg] }, :processors => [ :poster ]
  
end