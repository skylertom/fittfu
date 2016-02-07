require 'rails_helper'

describe Membership do
  let(:membership) { build(:membership) }
  subject { membership }

  it { should respond_to (:team_id) }
  it { should respond_to (:player_id) }
  it { should respond_to (:captain) }

  it 'has a valid factory' do
    expect(build(:game)).to be_valid
  end

  it 'not to be a captain by default' do
    expect(membership.captain).to be false
  end

  describe 'ActiveModel validations' do
    before (:each) { allow(subject).to receive(:create_game_stats) }
    it { expect(subject).to validate_presence_of(:team_id) }
    it { expect(subject).to validate_presence_of(:player_id) }
    it { expect(subject).to validate_uniqueness_of(:team_id).scoped_to(:player_id) }
  end

  describe 'ActiveRecord associations' do
    it { expect(subject).to belong_to(:team) }
    it { expect(subject).to belong_to(:player) }
  end

  describe 'scopes' do
    it '.real returns real memberships' do
      membership = create(:membership, fantasy: false)
      expect(Membership.real.first).to eq(membership)
    end

    it '.real does not return fantasy memberships' do
       create(:membership, fantasy: true)
      expect(Membership.real.any?).to be false
    end

    it '.for_fantasy returns fantasy memberships' do
      membership = create(:membership, fantasy: true)
      expect(Membership.for_fantasy.first).to eq(membership)
    end

    it '.for_fantasy does not return real memberships' do
      create(:membership, fantasy: false)
      expect(Membership.for_fantasy.any?).to be false
    end

    it '.for returns memberships for a team' do
      team = create(:team)
      membership = create(:membership, team: team)
      expect(Membership.for(team).first).to eq(membership)
    end

    it '.non_captains returns non captain memberships' do
      membership = create(:membership, captain: false)
      expect(Membership.non_captains.first).to eq(membership)
    end

    it '.non_captains does not return captain memberships' do
      create(:membership, captain: true)
      expect(Membership.non_captains.any?).to be false
    end

    it '.captains returns non captain memberships' do
      membership = create(:membership, captain: true)
      expect(Membership.captains.first).to eq(membership)
    end

    it '.captains does not return captain memberships' do
      create(:membership, captain: false)
      expect(Membership.captains.any?).to be false
    end
  end
end