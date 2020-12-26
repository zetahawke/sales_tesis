class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_at, default: (DateTime.current + 3.days)
      t.datetime :ends_at, default: (DateTime.current + 7.days)
      t.datetime :appointed_at, default: (DateTime.current + 4.days)
      t.datetime :realized_at
      t.boolean :accomplished, default: false
      t.references :visit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
