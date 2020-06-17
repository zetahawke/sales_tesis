class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :acceptance_criteria, null: false, foreign_key: true

      t.timestamps
    end
  end
end
