class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  TYPE = %w(ADMIN COMMISSIONER)
  ADMIN = 0
  COMMISSIONER = 1

  def is_admin?
    user_type == ADMIN
  end

  def is_commissioner?
    user_type == COMMISSIONER
  end
end
