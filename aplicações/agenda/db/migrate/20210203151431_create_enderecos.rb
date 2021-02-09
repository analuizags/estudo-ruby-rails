class CreateEnderecos < ActiveRecord::Migration
  def change
    create_table :enderecos do |t|
      t.string :endereco
      t.string :cidade
      t.string :estado
      t.references :contato, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
