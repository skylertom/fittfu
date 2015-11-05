require 'rails_helper'

describe Game do
  let(:game) { FactoryGirl.build(:game) }
  subject { game }

  it { should respond_to (:time_slot) }
  it { should respond_to (:week) }

  describe '#validations' do
    it 'should be valid' do
      expect(game).to be_valid
    end

    it 'should not be valid without a week' do
      game.week = nil
      expect(game).to_not be_valid
    end

    it 'should not be valid without a time_slot' do
      game.time_slot = nil
      expect(game).to_not be_valid
    end
  end
end