class CreateConta < ActiveRecord::Migration[5.2]
  def change
    create_table :conta do |t|
      t.references :tipo_conta, foreign_key: true
      t.string :cadastro
      t.string :referencia
      t.string :vencimento
      t.decimal :valor

      t.timestamps
    end
  end
end
