class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.string :description
      t.integer :acceptance_criterias, array: true

      t.timestamps
    end
  end
end
