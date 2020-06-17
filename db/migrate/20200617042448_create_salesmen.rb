class CreateSalesmen < ActiveRecord::Migration[6.0]
  def change
    create_table :salesmen do |t|
      t.string :name

      t.timestamps
    end
  end
end
