class ChangeTypeForScheduledDate < ActiveRecord::Migration[6.1]
  def change
    change_column :calendars, :scheduled_date, :date
  end
end
