class CreateJoinTableLessonsTasks < ActiveRecord::Migration[6.0]
  def change
    create_join_table :lessons, :tasks do |t|
      # t.index [:lesson_id, :task_id]
      # t.index [:task_id, :lesson_id]
    end
  end
end
