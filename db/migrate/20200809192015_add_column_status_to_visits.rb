class AddColumnStatusToVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :visits, :status, :integer, default: 0
  end
end
