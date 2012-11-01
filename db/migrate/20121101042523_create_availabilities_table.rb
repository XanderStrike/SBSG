class CreateAvailabilitiesTable < ActiveRecord::Migration
  def up
    create_table :availabilities do |t|
      t.integer :employee_id
      t.time :start
      t.time :end
      t.integer :day
      t.integer :business_id

      t.timestamps
    end
  end

  def down
    drop_table :availabilities
  end
end
