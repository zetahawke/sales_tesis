class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals do |t|
      t.references :salesman, null: false, foreign_key: true
      t.string :type
      t.string :criteria
      t.string :criteria_value

      t.timestamps
    end
  end
end
