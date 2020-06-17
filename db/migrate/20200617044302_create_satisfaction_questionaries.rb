class CreateSatisfactionQuestionaries < ActiveRecord::Migration[6.0]
  def change
    create_table :satisfaction_questionaries do |t|
      t.references :visit, null: false, foreign_key: true
      t.integer :questions, array: true

      t.timestamps
    end
  end
end
