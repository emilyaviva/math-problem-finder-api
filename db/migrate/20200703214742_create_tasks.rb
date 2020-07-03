class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :source
      t.string :link
      t.string :commentary

      t.timestamps
    end
  end
end
