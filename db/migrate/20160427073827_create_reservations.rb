class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations, id: false do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps null: false
    end
    execute "ALTER TABLE reservations ADD PRIMARY KEY (user_id, event_id);"
  end
end
