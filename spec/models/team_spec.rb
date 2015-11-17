require 'rails_helper'

describe Team do
  let(:team) { build(:team) }
  let(:player) { build(:player) }
  subject { team }

  it { should respond_to (:name) }
  it { should respond_to (:color) }

  it 'has a valid factory' do
    expect(build(:team)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:color) }
  end

  describe 'ActiveRecord associations' do
    it { expect(subject).to have_many(:memberships).dependent(:destroy) }
    it { expect(subject).to have_many(:players).through(:memberships) }
    it { expect(subject).to have_many(:team_games).dependent(:destroy) }
    it { expect(subject).to have_many(:games).through(:team_games).dependent(:destroy) }
    it { expect(subject).to have_one(:captain_membership) }
    it { expect(subject).to have_one(:captain).through(:captain_membership) }
  end

  describe 'scopes' do
    it '.real returns all real teams' do
      team = create(:team, fantasy: false)
      expect(Team.real.first).to eq(team)
    end

    it '.real does not return fantasy teams' do
      create(:team, fantasy: true)
      expect(Team.real.any?).to be false
    end

    it '.fantasy returns all fantasy teams' do
      team = create(:team, fantasy: true)
      expect(Team.for_fantasy.first).to eq(team)
    end

    it '.fantasy does not return real teams' do
      create(:team, fantasy: false)
      expect(Team.for_fantasy.any?).to be false
    end
  end
end