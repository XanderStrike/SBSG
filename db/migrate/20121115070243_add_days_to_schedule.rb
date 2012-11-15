class AddDaysToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :monday, :string, :default => {:width => 0, :height => 0, :depth => 0}.to_yaml
    add_column :schedules, :tuesday, :string, :default => {:width => 0, :height => 0, :depth => 0}.to_yaml
    add_column :schedules, :wednesday, :string, :default => {:width => 0, :height => 0, :depth => 0}.to_yaml
    add_column :schedules, :thursday, :string, :default => {:width => 0, :height => 0, :depth => 0}.to_yaml
    add_column :schedules, :friday, :string, :default => {:width => 0, :height => 0, :depth => 0}.to_yaml
    add_column :schedules, :saturday, :string, :default => {:width => 0, :height => 0, :depth => 0}.to_yaml
    add_column :schedules, :sunday, :string, :default => {:width => 0, :height => 0, :depth => 0}.to_yaml
  end
end
