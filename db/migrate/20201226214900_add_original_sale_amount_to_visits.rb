class AddOriginalSaleAmountToVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :visits, :original_sale_amount, :float, default: 0.0
  end
end
