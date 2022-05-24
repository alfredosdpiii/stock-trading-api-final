require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'validating transaction associations' do
    it 'belongs to a user' do
      transaction = Transaction.new
      user = User.new
      user.transactions << transaction
      expect(transaction.user).to be(user)
    end
  end
end

