class User < ApplicationRecord
  validates_presence_of :first_name, :last_name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, 
         jwt_revocation_strategy: self
  has_many :tweets
  has_many :follows

  def generate_jwt
    JWT.encode({ id: id,
                exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def followers
    ids = Follow.where(following_id: self.id).pluck(:user_id)
    followers = User.where(id: ids)
    return followers
  end

end
