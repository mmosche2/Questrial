class AddPhotoToQuests < ActiveRecord::Migration
  def self.up
    add_column :quests, :photo_file_name, :string # Original filename
    add_column :quests, :photo_content_type, :string # Mime type
    add_column :quests, :photo_file_size, :integer # File size in bytes
	add_column :quests, :photo_updated_at,  :datetime
  end

  def self.down
    remove_column :quests, :photo_file_name
    remove_column :quests, :photo_content_type
    remove_column :quests, :photo_file_size
	remove_column :quests, :photo_updated_at
  end
end
