class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :work_session, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
