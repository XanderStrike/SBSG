module ShiftsHelper
  Human_Readable_Days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  def human_readable_day(day)
    Human_Readable_Days[day]
  end
end
