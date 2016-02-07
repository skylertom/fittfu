require 'rails_helper'

describe GameStat do
  let(:game_stat) { build(:game_stat) }
  subject { game_stat }


  it { should respond_to (:team_game_id) }
  it { should respond_to (:player_id) }
  it { should respond_to (:ds) }
  it { should respond_to (:turns) }
  it { should respond_to (:goals) }
  it { should respond_to (:assists) }

  it 'has a valid factory' do
    expect(build(:game_stat)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:player_id) }
    it { expect(subject).to validate_presence_of(:team_game_id) }
  end

  describe 'Initialize Game Stats' do
    it { expect(subject.ds).to eq(0) }
    it { expect(subject.turns).to eq(0) }
    it { expect(subject.goals).to eq(0) }
    it { expect(subject.assists).to eq(0) }
  end

  describe 'ActiveRecord associations' do
    it { expect(subject).to belong_to(:player) }
    it { expect(subject).to belong_to(:team_game) }
    it { expect(subject).to have_one(:team).through(:player) }
  end

  describe 'public instance methods' do
    context 'responds to its methods' do
      it { expect(subject).to respond_to(:points) }
    end

    context 'executes methods correctly' do
      context '#points' do
        it 'evaluates number of points' do
          subject.ds = 1
          subject.goals = 2
          subject.turns = 1
          expect(subject.points).to eq(7)
        end
      end
    end
  end
end