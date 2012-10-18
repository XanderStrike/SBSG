class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :mon_start
      t.integer :mon_end
      t.integer :tue_start
      t.integer :tue_end
      t.integer :wed_start
      t.integer :wed_end
      t.integer :thu_start
      t.integer :thu_end
      t.integer :fri_start
      t.integer :fri_end
      t.integer :sat_start
      t.integer :sat_end
      t.integer :sun_start
      t.integer :sun_end
      t.string :days_off

      t.timestamps
    end
  end
end
