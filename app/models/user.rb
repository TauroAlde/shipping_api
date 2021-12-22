class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :username, uniqueness: true, case_sensitive: true

end
