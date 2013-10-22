class CreateEventMemberships < ActiveRecord::Migration
  def change
    create_table :event_memberships do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
