class RenameStartsAtToScheduledDate < ActiveRecord::Migration[6.1]
  def change
    rename_column :calendars, :starts_at, :scheduled_date
  end
end
