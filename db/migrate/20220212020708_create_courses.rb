class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name, index: true
      t.decimal :price
      t.integer :currency
      t.integer :validity_duration
      t.string :status

      t.timestamps
    end
  end
end
