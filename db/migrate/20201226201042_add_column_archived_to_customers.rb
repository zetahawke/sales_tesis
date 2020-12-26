class AddColumnArchivedToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :archived, :boolean, default: false
  end
end
