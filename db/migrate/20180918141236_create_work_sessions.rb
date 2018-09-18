class CreateWorkSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :work_sessions do |t|
      t.datetime :started_at
      t.datetime :ended_at

      t.references :day, foreign_key: true
      t.timestamps
    end
  end
end
