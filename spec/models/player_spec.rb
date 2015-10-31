require 'rails_helper'

describe Player do
  let(:player) { FactoryGirl.build(:player) }
  subject { player }


  it { should respond_to (:name) }
  it { should respond_to (:gender) }

  describe '#validations' do
    it 'should be valid' do
      expect(player).to be_valid
    end

    it 'should not be valid without a name' do
      player.name = nil
      expect(player).to_not be_valid
    end
  end

  describe '#associations' do
    it 'should destroy dependent memberships' do
      player.save!
      FactoryGirl.create(:membership, player: player)
      expect { player.destroy}.to change {Membership.count}.by(-1)
    end
  end
end