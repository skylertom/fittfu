require 'rails_helper'

describe Game do
  let(:game) { build(:game) }
  subject { game }

  it { should respond_to (:time_slot) }
  it { should respond_to (:week) }

  it 'has a valid factory' do
    expect(build(:game)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:week) }
    it { expect(subject).to validate_presence_of(:time_slot) }
  end

  describe 'ActiveRecord associations' do
    it { expect(subject).to have_many(:team_games) }
    it { expect(subject).to have_many(:teams).through(:team_games) }
    it { expect(subject).to have_many(:players).through(:teams) }
  end

  describe 'scopes' do
    it '.upcoming returns all future games' do
      game = create(:game, time: Time.zone.now.advance(minutes: 5))
      expect(Game.upcoming.first).to eq(game)
    end

    it '.upcoming does not return past games' do
      create(:game, time: Time.zone.now)
      expect(Game.upcoming.any?).to be false
    end

    it '.past returns all past games' do
      game = create(:game, time: Time.zone.now)
      expect(Game.past.first).to eq(game)
    end

    it '.past does not return future games' do
      create(:game, time: Time.zone.now.advance(minutes: 5))
      expect(Game.past.any?).to be false
    end
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(game).to respond_to(:has_teams?) }
      it { expect(game).to respond_to(:name) }
    end

    context 'executes methods correctly' do
      context '#has_teams?' do
        it 'returns false with no teams' do
          expect(game.teams.any?).to be false
          expect(game.has_teams?).to be false
        end
        it 'returns false with one team' do
          game.save!
          game.team_games.create(team_id: create(:team).id)
          expect(game.teams.size).to eq(1)
          expect(game.has_teams?).to be false
        end
        it 'returns true with two teams' do
          game.save!
          game.team_games.create(team_id: create(:team).id)
          game.team_games.create(team_id: create(:team).id)
          expect(game.teams.size).to eq(2)
          expect(game.has_teams?).to be true
        end
      end

      context '#name' do
        it 'has default text with not enough teams' do
          expect(game.has_teams?).to be false
          expect(game.name).to eq "Not enoughh teams assigned"
        end

        it 'returns title of the two teams' do
          game.save!
          game.team_games.create(team_id: create(:team).id)
          game.team_games.create(team_id: create(:team).id)
          expect(game.name).to eq "#{game.teams.first.name} VS #{game.teams.second.name}"
        end
      end
    end
  end
end