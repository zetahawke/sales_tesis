class CreateExcuses < ActiveRecord::Migration[6.0]
  def change
    create_table :excuses do |t|
      t.string :reason
      t.boolean :valid, default: :true
      t.references :visit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
