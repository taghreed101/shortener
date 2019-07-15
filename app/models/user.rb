require 'byebug'

class User < ActiveRecord::Base
    has_many :urls ,{:foreign_key => :user_id}
  validates_presence_of :name, :email, :password
  #validates :email,uniqueness:{case_sensitive: false} # true or 
 include  BCrypt


 def password
  
  @password ||= Password.new(password_hash)
end

def password= (new_password)
  #byebug
  @password=Password.create(new_password)
  self.password_hash= @password
end
end