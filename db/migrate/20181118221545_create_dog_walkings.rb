class CreateDogWalkings < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_walkings do |t|
      t.integer :status
      t.float :price
      t.float :duration
      t.float :latitude
      t.float :longitude
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
