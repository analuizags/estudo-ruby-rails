class Telefone < ActiveRecord::Base
    belongs_to :contato

    validates :ddd, presence: true
    validates :numero, presence: true
    validates :numero, numericality: { 
        greater_than_or_equal_to: 900000000, 
        less_than_or_equal_to: 999999999 }
end
