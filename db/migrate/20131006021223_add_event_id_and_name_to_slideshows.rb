class AddEventIdAndNameToSlideshows < ActiveRecord::Migration
  def change
    add_column :slideshows, :event_id, :integer
    add_column :slideshows, :name, :string
  end
end
