class CreateJoinTableCoursesTalents < ActiveRecord::Migration[6.0]
  def change
    create_join_table :courses, :talents do |t|
      t.index [:course_id, :talent_id]
      t.index [:talent_id, :course_id]
    end
  end
end
