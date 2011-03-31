class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string    :title
      t.string    :doc_file_name
      t.string    :doc_content_type
      t.integer   :doc_file_size
      t.datetime  :doc_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
