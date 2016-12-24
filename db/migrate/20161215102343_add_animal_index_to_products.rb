class AddAnimalIndexToProducts < ActiveRecord::Migration
  def change
      add_reference :products, :animal,index: true
  end
end
