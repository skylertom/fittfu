require 'rails_helper'

describe TeamGame do
  let(:team_game) { build(:team_game) }
  subject { team_game }

  it { should respond_to (:game_id) }
  it { should respond_to (:team_id) }

  it 'has a valid factory' do
    expect(build(:team_game)).to be_valid
  end

  describe 'ActiveModel validations' do
    before(:each) do
      allow(subject).to receive(:create_game_stats)
    end
    it { expect(subject).to validate_presence_of(:game_id) }
    it { expect(subject).to validate_presence_of(:team_id) }
    it { expect(subject).to validate_uniqueness_of(:team_id).scoped_to(:game_id) }
  end

  describe 'callbacks' do
    it 'makes and deletes  game stats after being made/destroyed' do
      team_game.team.players.create(name: "pudge")
      expect { team_game.save }.to change {GameStat.count}.by(1)
      expect { team_game.destroy }.to change {GameStat.count}.by(-1)
    end
  end

  describe 'ActiveRecord associations' do
    it { expect(subject).to belong_to(:game) }
    it { expect(subject).to belong_to(:team) }
  end
end
