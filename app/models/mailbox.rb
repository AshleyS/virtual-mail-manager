class Mailbox < ActiveRecord::Base
  belongs_to :domain

  validates_presence_of :domain_id, :email

  before_save :encrypt_password

  def encrypt_password
    self.password = Digest::MD5.hexdigest( self.password )
  end

end
