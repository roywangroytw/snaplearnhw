class AddCourseIntroToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :introduction, :text
  end
end
