class AddColumnsToAcceptanceCriterium < ActiveRecord::Migration[6.0]
  def change
    add_column :acceptance_criteria, :hit_value, :integer, default: 0
  end
end
