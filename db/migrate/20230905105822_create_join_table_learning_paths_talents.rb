class CreateJoinTableLearningPathsTalents < ActiveRecord::Migration[6.0]
  def change
    create_join_table :learning_paths, :talents do |t|
      t.index [:learning_path_id, :talent_id]
      t.index [:talent_id, :learning_path_id]
    end
  end
end
