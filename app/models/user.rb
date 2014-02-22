class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :posts
  
  has_many :out_followings, class_name: "Following", foreign_key: :from_id, dependent: :destroy
  has_many :followed_users, class_name: "User", through: :out_followings, source: :to
  has_many :in_followings, class_name: "Following", foreign_key: :to_id, dependent: :destroy
  has_many :followers, class_name: "User", through: :in_followings, source: :from
  
  def follow(user)
    out_followings.create(to_id: user.id)
  end
  
  def unfollow(user)
    following = out_followings.find_by(to_id: user.id)
    if following
      following.destroy
      true
    else
      false
    end
  end
  
  def following?(user)
    if followed_users.exists?(user.id)
      true
    else
      false
    end
  end
  
  def followed_by(user)
    if followers.exists?(user.id)
      true
    else
      false
    end
  end
  
end
