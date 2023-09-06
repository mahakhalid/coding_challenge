class CreateCompletedCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :completed_courses do |t|
      t.references :course, null: false, foreign_key: true
      t.references :talent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
