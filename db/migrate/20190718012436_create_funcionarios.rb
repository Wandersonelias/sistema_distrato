class CreateFuncionarios < ActiveRecord::Migration[5.2]
  def change
    create_table :funcionarios do |t|
      t.string :nome
      t.string :setor
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
