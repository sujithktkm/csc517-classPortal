class UsersIsActiveuserField < ActiveRecord::Migration
  def change
    add_column :users, :is_activeuser, :boolean, default: true
  end
end
