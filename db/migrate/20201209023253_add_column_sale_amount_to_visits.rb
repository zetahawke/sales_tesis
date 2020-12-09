class AddColumnSaleAmountToVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :visits, :sale_amount, :float, default: 0.0
  end
end
