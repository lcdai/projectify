class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :status
      t.string :priority
      t.date :due_date

      t.timestamps
    end
  end
end
