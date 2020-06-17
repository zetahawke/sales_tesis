class CreateAcceptanceCriteria < ActiveRecord::Migration[6.0]
  def change
    create_table :acceptance_criteria do |t|
      t.string :name
      t.string :criteria
      t.string :criteria_value

      t.timestamps
    end
  end
end
