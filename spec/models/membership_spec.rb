require 'rails_helper'

describe Membership do

  describe '#validations' do
    it 'does not allow a role to be nil' do
      m = Membership.new
      m.valid?
      expect(m.errors[:role]).to be_present
    end

    it 'allows all group roles' do
      Team::Role::ROLES.each do |role|
        m = Membership.new(role: role)
        m.valid?
        expect(m.errors[:role]).to be_blank
      end
    end
  end
end