class CreateMoneyGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :money_goals do |t|
      t.integer :amount
      t.references :salesman, null: false, foreign_key: true
      t.string :type_of_criteria

      t.timestamps
    end
  end
end
