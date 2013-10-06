class CreateSlideshows < ActiveRecord::Migration
  def change
    create_table :slideshows do |t|
      t.integer :slide_num
      t.string :url

      t.timestamps
    end
  end
end
