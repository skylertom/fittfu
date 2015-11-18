class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin_or_commissioner?
    admin || commissioner
  end

  # TODO remove
  def is_admin?
    true
  end

  # TODO remove
  def is_commissioner?
    true
  end
end
