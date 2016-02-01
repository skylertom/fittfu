require 'rails_helper'
require 'pundit/rspec'

describe GameStatPolicy do
  let(:user) { build(:user)}
  let(:commissioner) { build(:user, :commissioner)}
  let(:admin) { build(:user, :admin)}
  let(:game_stat) { build(:game_stat)}
  subject { described_class }

  permissions :update? do
    it "denies access if not admin or commissioner" do
      expect(subject).not_to permit(user, game_stat)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin, game_stat)
    end

    it "grants access if user is a commissioner" do
      expect(subject).to permit(commissioner, game_stat)
    end
  end
end