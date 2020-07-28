class AddColumnEmailToSalesman < ActiveRecord::Migration[6.0]
  def change
    add_column :salesmen, :private_token, :string
  end
end
