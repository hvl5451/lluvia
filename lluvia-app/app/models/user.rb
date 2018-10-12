class User < ApplicationRecord

  #query by email
  scope :search, lambda {|query| where(["email LIKE ?", "%#{query}%"])}

end
