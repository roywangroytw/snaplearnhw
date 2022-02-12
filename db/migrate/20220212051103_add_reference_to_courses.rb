class AddReferenceToCourses < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :user, index: true
  end
end
