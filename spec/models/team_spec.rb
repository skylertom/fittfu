require 'rails_helper'

describe Team do
  let(:team) { FactoryGirl.build(:team) }
  let(:player) { FactoryGirl.build(:player) }
  subject { team }

  it { should respond_to (:name) }
  it { should respond_to (:color) }

  describe '#validations' do
    it 'should be valid' do
      expect(team).to be_valid
    end

    it 'should not be valid without a name' do
      team.name = nil
      expect(team).to_not be_valid
    end

    it 'should not be valid without a color' do
      team.color = nil
      expect(team).to_not be_valid
    end
  end

  describe '#associations' do
    before(:each) { team.save! }
    it 'should destroy dependent memberships' do
      FactoryGirl.create(:membership, team: team)
      expect { team.destroy}.to change {Membership.count}.by(-1)
    end

    it 'should have a captain' do
      player.save!
      FactoryGirl.create(:membership, :captain, team: team, player: player)
      expect(team.captain_membership).to eq(player.memberships.first)
      expect(team.captain).to eq(player)
    end
  end
end