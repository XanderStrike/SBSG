class CreateAssignments < ActiveRecord::Migration
  def up
    create_table :assignments do |t|
      t.integer :schedule_id
      t.integer :shift_id
      t.integer :employee_id

      t.timestamps
    end
  end

  def down
    drop_table :assignments
  end
end
