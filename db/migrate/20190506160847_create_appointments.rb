class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :schedule_id
      t.integer :start_time
      t.integer :end_time
      t.timestamps
    end
  end
end
