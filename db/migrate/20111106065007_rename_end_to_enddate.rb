class RenameEndToEnddate < ActiveRecord::Migration
  def change
    rename_column :quests, :end, :enddate
  end

end
