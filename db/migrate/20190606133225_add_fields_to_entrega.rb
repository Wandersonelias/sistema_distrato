class AddFieldsToEntrega < ActiveRecord::Migration[5.2]
  def change
    add_column :entregas, :implemento, :decimal
    add_column :entregas, :multa, :decimal
    add_column :entregas, :condominio, :decimal
    add_column :entregas, :encargos, :decimal
    add_column :entregas, :debito_diversos, :decimal
    add_column :entregas, :credito, :decimal
    add_column :entregas, :caucao, :decimal
  end
end
