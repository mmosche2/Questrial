class AddDatesToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :startdate, :date
    add_column :experiences, :enddate, :date
  end
end
