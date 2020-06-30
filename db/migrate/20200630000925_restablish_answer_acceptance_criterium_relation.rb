class RestablishAnswerAcceptanceCriteriumRelation < ActiveRecord::Migration[6.0]
  def change
    remove_column :answers, :acceptance_criteria_id
    add_column :answers, :acceptance_criterium_id, :integer, null: false, foreign_key: true
  end
end
