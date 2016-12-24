class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :fullname
      t.string :subject
      t.text :message

      t.timestamps null: false
    end
  end
end
