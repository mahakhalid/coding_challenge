class AddLearningPathToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :learning_path, foreign_key: true
  end
end


