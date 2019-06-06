class CreateAluguels < ActiveRecord::Migration[5.2]
  def change
    create_table :aluguels do |t|
      t.string :periodo
      t.string :data_vencimento
      t.string :previsao_pagamento
      t.decimal :valor_aluguel
      t.decimal :multa
      t.decimal :juros

      t.timestamps
    end
  end
end
