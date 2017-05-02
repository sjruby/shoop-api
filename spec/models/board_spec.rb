require 'rails_helper'

RSpec.describe Board, type: :model do
  describe 'model associations' do
      def association
        described_class.reflect_on_association(:user)
      end

      it 'has one user' do
        expect(association).to_not be_nil
        expect(association.name).to eq(:user)
      end
   end
end
