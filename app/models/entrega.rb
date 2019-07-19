class Entrega < ApplicationRecord
    belongs_to :user
    validates :multa,:presence => true
end
