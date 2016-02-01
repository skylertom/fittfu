require 'rails_helper'
require 'pundit/rspec'

describe TeamPolicy do
  let(:user) { build(:user)}
  let(:commissioner) { build(:user, :commissioner)}
  let(:admin) { build(:user, :admin)}
  let(:team) { build(:team)}

  subject { described_class }

  permissions :new?, :update?, :create?, :destroy? do
    it "denies access if not admin or commissioner" do
      expect(subject).not_to permit(user, team)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin, team)
    end

    it "grants access if user is a commissioner" do
      expect(subject).to permit(commissioner, team)
    end
  end
end