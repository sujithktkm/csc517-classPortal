class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :type
      t.boolean :deletable, default: true
      t.timestamps null: false
    end
  end
end
