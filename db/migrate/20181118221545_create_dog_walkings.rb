class CreateDogWalkings < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walkings do |t|
      t.integer :status, :default => 0
      t.integer :pets
      t.float :price
      t.integer :duration
      t.float :latitude
      t.float :longitude
      t.time :start
      t.time :finish
      t.datetime :scheduled_day

      t.timestamps
    end
  end
end
