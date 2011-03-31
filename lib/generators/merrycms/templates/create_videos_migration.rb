class CreateVideos < ActiveRecord::Migration
  def self.up
    create_table :videos do |t|
      t.string    :title
      t.timestamps
    end
    
    create_table :sources do |t|
      t.integer   :video_id
      t.string    :width
      t.string    :height
      t.string    :container_type
      t.string    :video_file_name
      t.string    :video_content_type
      t.integer   :video_file_size
      t.datetime  :video_updated_at
    end
    
  end

  def self.down
    drop_table :videos
    drop_table :sources
  end
end
