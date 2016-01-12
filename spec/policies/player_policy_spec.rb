require 'rails_helper'
require 'pundit/rspec'

describe PlayerPolicy do
  let(:user) { build(:user)}
  let(:commissioner) { build(:user, :commissioner)}
  let(:admin) { build(:user, :admin)}
  let(:player) { build(:player)}

  subject { described_class }

  permissions :new?, :update?, :create?, :destroy? do
    it "denies access if not admin or commissioner" do
      expect(subject).not_to permit(user, player)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin, player)
    end

    it "grants access if user is a commissioner" do
      expect(subject).to permit(commissioner, player)
    end
  end
end