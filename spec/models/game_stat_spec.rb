require 'rails_helper'

describe GameStat do
  let(:game_stat) { FactoryGirl.build(:game_stat) }
  subject { game_stat }


  it { should respond_to (:team_game_id) }
  it { should respond_to (:player_id) }
  it { should respond_to (:ds) }
  it { should respond_to (:turns) }
  it { should respond_to (:goals) }
  it { should respond_to (:assists) }

  it 'should expect stats to be initialized to 0' do
    expect(game_stat.ds).to eq(0)
    expect(game_stat.turns).to eq(0)
    expect(game_stat.goals).to eq(0)
    expect(game_stat.assists).to eq(0)
  end

  describe '#validations' do
    it 'should be valid' do
      expect(game_stat).to be_valid
    end

    it 'should not be valid without a team' do
      game_stat.team_game_id = nil
      expect(game_stat).to_not be_valid
    end

    it 'should not be valid without a game' do
      game_stat.player_id = nil
      expect(game_stat).to_not be_valid
    end
  end
end