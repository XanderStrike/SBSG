class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :schedule

      t.timestamps
    end
  end
end
