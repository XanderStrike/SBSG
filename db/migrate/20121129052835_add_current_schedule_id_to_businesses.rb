class AddCurrentScheduleIdToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :current_schedule_id, :integer
  end
end
