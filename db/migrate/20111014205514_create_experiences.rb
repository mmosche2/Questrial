class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :joiner_id
      t.integer :joined_id

      t.timestamps
    end
	add_index :experiences, :joiner_id
    add_index :experiences, :joined_id
    add_index :experiences, [:joiner_id, :joined_id], :unique => true
  end
end
