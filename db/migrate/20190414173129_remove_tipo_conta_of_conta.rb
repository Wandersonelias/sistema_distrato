class RemoveTipoContaOfConta < ActiveRecord::Migration[5.2]
  def change
    remove_column :conta, :tipo_conta_id
  end
end
