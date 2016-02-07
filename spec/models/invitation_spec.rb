require 'rails_helper'

describe Invitation do
  let(:invitation) { build(:invitation, :admin) }
  subject { invitation }


  it { should respond_to (:code) }
  it { should respond_to (:user_id) }
  it { should respond_to (:invitor_id) }
  it { should respond_to (:authority) }
  it { should respond_to (:accepted) }

  it 'has a valid factory' do
    expect(build(:invitation, :admin)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:invitor_id) }
    it { expect(subject).to validate_presence_of(:code) }
    it { expect(subject).to validate_presence_of(:authority) }
  end

  describe 'ActiveRecord associations' do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to belong_to(:invitor) }
  end

  describe 'public class methods' do
    context 'responds to its methods' do
      it { expect(Invitation).to respond_to(:find_valid) }
    end

    context 'executes methods correctly' do
      context '#find_valid' do
        it 'evaluates bad code' do
          expect(Invitation.find_valid("lololol")).to eq nil
        end
        it 'does not accept already accepted invites' do
          invitation.save
          invitation.update_attribute(:accepted, 1)
          expect(Invitation.find_valid(invitation.code)).to eq nil
        end
        it 'returns the correct invitation' do
          invitation.save
          expect(Invitation.find_valid(invitation.code)).to eq invitation
        end
      end
    end
  end
end