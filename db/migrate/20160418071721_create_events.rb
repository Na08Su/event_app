class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.datetime :event_date
      t.string :place

      t.timestamps null: false
    end
  end
end
