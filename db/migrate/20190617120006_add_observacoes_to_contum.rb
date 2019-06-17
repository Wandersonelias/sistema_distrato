class AddObservacoesToContum < ActiveRecord::Migration[5.2]
  def change
    add_column :conta, :observacao, :text
  end
end
