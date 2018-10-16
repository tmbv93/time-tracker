class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.timestamps
    end

    add_reference :days, :report, index: true, foreign_key: true
  end
end
