class AddRelationSatisfactionQuestionaryToAnswer < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :satisfaction_questionary_id, :integer, null: false, foreign_key: true
  end
end
