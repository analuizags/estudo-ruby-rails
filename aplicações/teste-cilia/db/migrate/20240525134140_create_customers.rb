class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :document
      t.date :birthdate
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
