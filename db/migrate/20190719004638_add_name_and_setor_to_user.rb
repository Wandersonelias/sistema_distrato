class AddNameAndSetorToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :nome, :string
    add_column :users, :setor, :string
  end
end
