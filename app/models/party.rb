class Party < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  validates :duration,
            :presence => true
  validates :day,
            :presence => true
  validates :start_time,
            :presence => true

  def find_invitee(params)
    all_users = User.all
    all_users.select do |user|
      params.keys.include?(user.email)
    end
  end

end
