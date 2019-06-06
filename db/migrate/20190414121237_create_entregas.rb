class CreateEntregas < ActiveRecord::Migration[5.2]
  def change
    create_table :entregas do |t|
      t.string :nome
      t.string :endereco
      t.string :processo

      t.timestamps
    end
  end
end
