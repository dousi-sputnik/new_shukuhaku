class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.integer :person
      t.integer :total_price
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
