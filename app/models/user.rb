class User < ActiveRecord::Base
  validates :email, uniqueness: true

  def self.authenticate(email, password)
    user = User.find_by(email: email, password: password)
    if user == nil
      nil
    else
      user
    end
  end
end
