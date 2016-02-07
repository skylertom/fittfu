require 'rails_helper'
require 'pundit/rspec'

describe InvitationPolicy do
  let(:user) { build(:user)}
  let(:commissioner) { build(:user, :commissioner)}
  let(:admin) { build(:user, :admin)}
  let(:invitation) { build(:invitation)}

  subject { described_class }

  permissions :new?, :create? do
    it "denies access if not admin or commissioner" do
      expect(subject).not_to permit(user, invitation)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin, invitation)
    end

    it "grants access if user is a commissioner" do
      expect(subject).to permit(commissioner, invitation)
    end
  end

  permissions :update?, :index?, :destroy? do
    it "denies access if not admin or commissioner" do
      expect(subject).not_to permit(user, invitation)
    end

    it "denies access if user is a commissioner" do
      expect(subject).not_to permit(commissioner, invitation)
    end

    it "grants access if user is an admin" do
      expect(subject).to permit(admin, invitation)
    end
  end
end