class AddSituacaoToEntrega < ActiveRecord::Migration[5.2]
  def change
    add_column :entregas, :situacao, :boolean, :default => 0
    #Ex:- :default =>''
  end
end
