class AddEntregaToReparo < ActiveRecord::Migration[5.2]
  def change
    add_reference :reparos, :entrega, foreign_key: true
  end
end
