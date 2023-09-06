class AddPositionToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :position, :integer
  end
end
