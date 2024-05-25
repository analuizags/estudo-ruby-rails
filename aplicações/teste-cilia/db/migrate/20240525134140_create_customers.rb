class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :document
      t.string :email
      t.date :birthdate

      t.timestamps
    end
  end
end
