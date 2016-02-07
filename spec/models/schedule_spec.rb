require 'rails_helper'

describe Schedule do
  let(:schedule) { build(:schedule) }
  subject { schedule }

  it { should respond_to (:start_time) }
  it { should respond_to (:end_time) }
  it { should respond_to (:year) }

  it 'has a valid factory' do
    expect(build(:schedule)).to be_valid
  end

  describe 'ActiveModel validations' do
    before(:each) do
      allow(subject).to receive(:assign_year)
    end

    it { expect(subject).to validate_presence_of(:start_time) }
    it { expect(subject).to validate_presence_of(:end_time) }
  end

  describe 'callbacks' do
    it 'sets year after create' do
      expect(subject.year).to be nil
      subject.save
      expect(subject.year).to eq subject.start_time.year
    end
  end

  describe 'scopes' do
    it '.for returns all events in that year' do
      schedule = create(:schedule)
      expect(Schedule.for(Time.zone.now.year).first).to eq(schedule)
    end

    it '.upcoming does not return past games' do
      create(:schedule)
      expect(Schedule.for(Time.zone.now.advance(years: 1).year).any?).to be false
    end
  end

end