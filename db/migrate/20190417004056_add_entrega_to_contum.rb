class AddEntregaToContum < ActiveRecord::Migration[5.2]
  def change
    add_reference :conta, :entrega, foreign_key: true
    
  end
end
