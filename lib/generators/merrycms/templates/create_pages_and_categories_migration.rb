class CreatePagesAndCategories < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string  :title
      t.text    :content
      t.text    :content_html
      t.string  :link
      t.string  :state
      t.datetime :published_at
      t.datetime :archived_at
      t.integer   :category_id
      t.timestamps
    end
    
    create_table :categories do |t|
      t.string  :name
      
      # nested_sey
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      # acts_as_list
      t.integer :position
      
      t.string  :link
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
    drop_table :categories
  end
end
