class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :slideshow_id
      t.string :note
      t.integer :slide_number

      t.timestamps
    end
  end
end
