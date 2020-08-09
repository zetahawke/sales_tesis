class RenameColumnValidForExcuse < ActiveRecord::Migration[6.0]
  def change
    rename_column :excuses, :valid, :valid_argument
  end
end
