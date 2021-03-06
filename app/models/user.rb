class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                   foreign_key: "follower_id",
                   dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                   foreign_key: "followed_id",
                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  attachment :profile_image

  def email_required?
  	false
  end

  def email_changed?
  	false
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.search(search)
    return User.all if search == ""
    User.where(['name LIKE ?', "%#{search}%"])
  end

  def self.search_front(search)
    return User.all if search == ""
    User.where(['name LIKE ?', "#{search}%"])
  end

  def self.search_back(search)
    return User.all if search == ""
    User.where(['name LIKE ?', " %#{search}"])
  end

  def self.search_all(search)
    return User.all if search == ""
    User.where(['name LIKE ?', "#{search}"])
  end
end
