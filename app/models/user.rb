class User < ActiveRecord::Base
  has_many :track_successes
  has_many :puzzles, through: :track_successes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def conquer_count
    TrackSuccess.where(:user_id => :id, :success => true).count
  end
end
