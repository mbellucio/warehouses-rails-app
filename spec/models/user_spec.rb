require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#description' do
    it 'display user name and email' do
      #arrange
      user = User.new(name: "Claiton", email: "claiton@gmail.com",
      password: "fogonababilonia" )
      #act
      result = user.description
      #assert
      expect(result).to eq("Claiton <claiton@gmail.com>")
    end
  end
end
