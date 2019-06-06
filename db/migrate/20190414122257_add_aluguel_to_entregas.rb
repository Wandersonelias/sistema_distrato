class AddAluguelToEntregas < ActiveRecord::Migration[5.2]
  def change
    add_reference :aluguels, :entrega, foreign_key: true
  end
end
