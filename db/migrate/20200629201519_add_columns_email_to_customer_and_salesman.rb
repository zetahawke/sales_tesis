class AddColumnsEmailToCustomerAndSalesman < ActiveRecord::Migration[6.0]
  def change
    add_column :salesmen, :email, :string
    add_column :customers, :email, :string
  end
end
