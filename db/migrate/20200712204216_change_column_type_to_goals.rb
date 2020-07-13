class ChangeColumnTypeToGoals < ActiveRecord::Migration[6.0]
  def change
    rename_column :goals, :type, :type_of_criteria 
  end
end
