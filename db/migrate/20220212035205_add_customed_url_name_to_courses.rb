class AddCustomedUrlNameToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :personalized_prefix, :string
  end
end
