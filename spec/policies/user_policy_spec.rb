require 'rails_helper'
require 'pundit/rspec'

describe UserPolicy do
  let(:user) { build(:user)}
  let(:commissioner) { build(:user, :commissioner)}
  let(:admin) { build(:user, :admin)}
  subject { described_class }

  permissions :destroy?, :index? do
    it "denies access if not admin or commissioner" do
      expect(subject).not_to permit(user)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin)
    end

    it "denies access if user is a commissioner" do
      expect(subject).not_to permit(commissioner)
    end
  end

  permissions :update? do
    it "is a pending example"
  end
end