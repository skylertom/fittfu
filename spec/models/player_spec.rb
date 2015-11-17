require 'rails_helper'

describe Player do
  let(:player) { build(:player) }
  subject { player }

  it { should respond_to (:name) }
  it { should respond_to (:gender) }

  it 'has a valid factory' do
    expect(build(:game)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:name) }
  end

  describe 'ActiveRecord associations' do
    it { expect(subject).to have_many(:memberships).dependent(:destroy) }
    it { expect(subject).to have_many(:teams).through(:memberships) }
    it { expect(subject).to have_one(:membership) }
    it { expect(subject).to have_one(:team).through(:membership) }
    it { expect(subject).to have_many(:game_stats).dependent(:destroy) }
  end
end