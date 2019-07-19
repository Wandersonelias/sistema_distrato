class AddUserRefToEntregas < ActiveRecord::Migration[5.2]
  def change
    add_reference :entregas, :user, foreign_key: true
  end
end
