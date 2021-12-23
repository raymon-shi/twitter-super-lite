class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password_hash
      t.text :bio
      t.string :birthday
      t.string :location

      t.timestamps
    end
  end
end
