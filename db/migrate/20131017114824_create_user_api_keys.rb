class CreateUserApiKeys < ActiveRecord::Migration
  def change
    create_table :user_api_keys do |t|
      t.string :access_token
      t.integer :user_id

      t.timestamps
    end
  end
end
