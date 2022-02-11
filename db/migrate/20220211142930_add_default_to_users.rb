class AddDefaultToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :course_creator, :boolean, default: false
  end
end
