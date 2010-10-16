# == Schema Information
# Schema version: 20101013185803
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }

# Password and confirmation are identical, password is between 6-40 characters
  validates :password, :presence => true,
            :confirmation => true,
            :length => { :within => 6..40 }

  before_save :encrypt_password

# Assigns encrypted password
  def has_password?(submitted_password) 
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)

    # if find by email is nil; no record, invalid email
    return nil if user.nil?

    # password mismatch with user
    return user if user.has_password?(submitted_password)
  end

# Alternate Authentication Methods
#  def User.authenticate(email, submitted_password)
#    user = find_by_email(email)
#    return nil  if user.nil?
#    return user if user.has_password?(submitted_password)
#  end

#  def self.authenticate(email, submitted_password)
#    user = find_by_email(email)
#    return nil  if user.nil?
#    return user if user.has_password?(submitted_password)
#    return nil
#  end


#  def self.authenticate(email, submitted_password)
#    user = find_by_email(email)
#    if user.nil?
#      nil
#    elsif user.has_password?(submitted_password)
#      user
#    else
#      nil
#    end
#  end

#  def self.authenticate(email, submitted_password)
#    user = find_by_email(email)
#    if user.nil?
#      nil
#    elsif user.has_password?(submitted_password)
#      user
#   end
#  end


  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
    # return nil if user.nil?
    # return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
    # return nil if user.nil?
    # return user if user.salt == cookie_salt
  end


# Method to generate and assign encrypted password (stub)
# Private section: Used internally inside Ruby object, not intended for
#                  public use.
  private

    # self keyword utilized to create a direct assignment
    # Note: self.password is optional (vs. encrypt(password) - value to be assigned
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(self.password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end





end

