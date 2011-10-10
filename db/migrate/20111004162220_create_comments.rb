class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :quest

      t.timestamps
    end
    add_index :comments, :quest_id
  end
end
