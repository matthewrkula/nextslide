class CreateEventsUsers < ActiveRecord::Migration
  def up
    create_table :events_users do |t|
      t.belongs_to :event
      t.belongs_to :user
    end
  end

  def down
    drop_table :events_users
  end
end
