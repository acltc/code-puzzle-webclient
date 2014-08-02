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

  def username
    array = self.email.split("")
    username = array[0] + array[1] + array[2] + array[3] + array[4]
  end

  def avg_puzzle_diff
    sum = 0.00
    count = 0.00
    TrackSuccess.where(:user_id => :id, :success => true).each do |success|
      puzzleid = success(:puzzle_id)
      sum += puzzle.find_by(puzzleid).diff
      count += 1.00
    end
    sum / count
  end
end
