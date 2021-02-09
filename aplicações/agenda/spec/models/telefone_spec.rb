require 'rails_helper'

describe Telefone do 
  telefone = Telefone.new( ddd: 61, numero: 928371010) 
  
  it "é válido quando nome, último nome e email estão presentes" do 
    expect(telefone).to be_valid 
  end 
end