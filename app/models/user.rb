class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub(/\s+/, '-')
  end

def self.find_by_slug(username)
  self.find_by_username(username.gsub('-', ' '))
end

end
