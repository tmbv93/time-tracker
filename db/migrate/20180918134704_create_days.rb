class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
