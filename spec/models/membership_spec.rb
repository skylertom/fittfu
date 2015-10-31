require 'rails_helper'

describe Membership do
  let(:membership) { FactoryGirl.build(:membership) }
  subject { membership }


  it { should respond_to (:team_id) }
  it { should respond_to (:player_id) }
  it { should respond_to (:captain) }
  it { should expect(captain).to be false }

  describe '#validations' do
    it 'should be valid' do
      expect(membership).to be_valid
    end

    it 'should not be valid without a team' do
      membership.team_id = nil
      expect(membership).to_not be_valid
    end

    it 'should not be valid without a game' do
      membership.player_id = nil
      expect(membership).to_not be_valid
    end
  end
end