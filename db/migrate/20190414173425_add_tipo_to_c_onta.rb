class AddTipoToCOnta < ActiveRecord::Migration[5.2]
  def change
    add_reference :conta, :tipo_contum, foreign_key: true
  end
end
