class RecreateEmployeesTables < ActiveRecord::Migration
  def up
    drop_table :employees
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.integer :business_id

      t.timestamps
    end
  end

  def down
    drop_table :employees
    create_table :employees do |t|
      t.string :name
      t.time :mon_start
      t.time :mon_end
      t.time :tue_start
      t.time :tue_end
      t.time :wed_start
      t.time :wed_end
      t.time :thu_start
      t.time :thu_end
      t.time :fri_start
      t.time :fri_end
      t.time :sat_start
      t.time :sat_end
      t.time :sun_start
      t.time :sun_end
      t.string :days_off
      t.integer :business_id

      t.timestamps
    end
  end
end
