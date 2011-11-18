class AddCategoryToQuest < ActiveRecord::Migration
  def change
    add_column :quests, :category_id, :integer
  end
end
