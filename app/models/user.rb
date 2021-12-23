class User < ApplicationRecord
  include BCrypt

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Interaction'
  has_many :followees, through: :followed_users
  
  has_many :following_users, foreign_key: :followee_id, class_name: 'Interaction'
  has_many :followers, through: :following_users

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true
  validates :username, uniqueness: {case_sensitive: true}
  validates :password_hash, presence: true
  validates :bio, presence: true
  validates :birthday, presence: true
  validates :location, presence: true
  
  tweets_arr = []


  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def full_name
    full_name = "#{first_name}" + " " + "#{last_name}"
    full_name
  end

  def self.tweets
    tweets_arr
  end


end
