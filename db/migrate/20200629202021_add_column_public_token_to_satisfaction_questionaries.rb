class AddColumnPublicTokenToSatisfactionQuestionaries < ActiveRecord::Migration[6.0]
  def change
    add_column :satisfaction_questionaries, :public_token, :string
  end
end
