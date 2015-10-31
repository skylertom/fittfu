require 'rails_helper'

describe TeamGame do
  let(:team_game) { FactoryGirl.build(:team_game) }
  subject { team_game }


  it { should respond_to (:team_id) }
  it { should respond_to (:game_id) }
  it { should respond_to (:points) }
  it 'should set points to 0 by default' do
    expect(team_game.points).to eq(0)
  end

  describe '#validations' do
    it 'should be valid' do
      expect(team_game).to be_valid
    end

    it 'should not be valid without a team' do
      team_game.team_id = nil
      expect(team_game).to_not be_valid
      end

    it 'should not be valid without a game' do
      team_game.game_id = nil
      expect(team_game).to_not be_valid
    end
  end
end