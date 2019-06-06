class CreateReparos < ActiveRecord::Migration[5.2]
  def change
    create_table :reparos do |t|
      t.string :descricao
      t.decimal :valor

      t.timestamps
    end
  end
end
