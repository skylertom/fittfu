require 'rails_helper'

describe MakeSchedule do
  describe '#call' do
    it 'should not run without teams' do
      expect(Team.count).to be 0
      expect { MakeSchedule.build.call(7) }.to_not change {Membership.count}
    end
    it 'should return false without teams' do
      expect(Team.count).to be 0
      expect(MakeSchedule.build.call(7)).to be false
    end

    it 'should be valid' do
      num_weeks = 7
      Team::STD_SIZE.times { FactoryGirl.create(:team) }
      expect { MakeSchedule.build.call(num_weeks) } .to change {Game.count}.by(num_weeks * Team::GAMES_IN_NIGHT)
      frequency = MakeSchedule.build.get_spread([0, 1, 2, 3, 4, 5, 6, 7].map { |team_num| Team.all[team_num].id })
      p frequency
      end
  end
end