class AddFieldsToEntrega < ActiveRecord::Migration[5.2]
  def change
    add_column :entregas, :implemento, :decimal , :default => 0.00
    add_column :entregas, :multa, :decimal , :default => 0.00
    add_column :entregas, :condominio, :decimal , :default => 0.00
    add_column :entregas, :encargos, :decimal , :default => 0.00
    add_column :entregas, :debito_diversos, :decimal , :default => 0.00
    add_column :entregas, :credito, :decimal , :default => 0.00
    add_column :entregas, :caucao, :decimal , :default => 0.00
  end
end
