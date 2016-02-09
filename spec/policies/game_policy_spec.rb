require 'rails_helper'
require 'pundit/rspec'

describe GamePolicy do
  let(:user) { build(:user)}
  let(:commissioner) { build(:user, :commissioner)}
  let(:admin) { build(:user, :admin)}
  let(:game) { build(:game)}
  subject { described_class }

  permissions :scorekeep?, :new?, :update?, :create?, :destroy? do
    it "denies access if not admin or commissioner" do
      expect(subject).not_to permit(user, game)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin, game)
    end

    it "grants access if user is a commissioner" do
      expect(subject).to permit(commissioner, game)
    end
  end

  permissions :create_schedule? do
    it "denies access if not admin or commissioner" do
      expect(subject).not_to permit(user, game)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin, game)
    end

    it "denies access if user is a commissioner" do
      expect(subject).not_to permit(commissioner, game)
    end
  end
end