class AddColumnPrivateTokenToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :private_token, :string
  end
end
