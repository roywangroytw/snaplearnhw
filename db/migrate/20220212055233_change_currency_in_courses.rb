class ChangeCurrencyInCourses < ActiveRecord::Migration[6.1]
  def change
    change_column :courses, :currency, :string
  end
end
