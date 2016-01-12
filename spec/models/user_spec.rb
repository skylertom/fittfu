require 'rails_helper'

describe User do
  let(:user) { build(:user) }
  subject { user }


  it { should respond_to (:email) }
  it { should respond_to (:name) }
  it { should respond_to (:admin) }
  it { should respond_to (:commissioner) }
  it { should respond_to (:invite_code) }
  it { should respond_to (:confirmed_at) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:email) }
    it "has pending tufts email validation"
  end
end