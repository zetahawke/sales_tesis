class SetExcuseValidArgumentDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :excuses, :valid_argument, :boolean, default: false
  end
end
