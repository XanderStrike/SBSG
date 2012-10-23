class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.time :mon_start

      t.timestamps
    end
  end
end
