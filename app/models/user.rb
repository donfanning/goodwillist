class User < ApplicationRecord
  validates :name, :email, :password_hash, presence: true
  validates :email, uniqueness: true

  has_and_belongs_to_many :list_items

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    return nil if new_password == ""
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, given_password)
    user = User.find_by_email(email)
    return nil if user == nil
    if user.password == given_password
      return user
    else
      return nil
    end
  end

end
