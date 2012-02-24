class Mailbox < ActiveRecord::Base
  belongs_to :domain

  validates_presence_of :domain_id, :email

  attr_accessible :domain_id, :email, :password

  before_save :encrypt_password

  set_table_name "virtual_users"

  def encrypt_password
    self.password = MailboxesHelper::Password.crypt( self.password )
  end

  def self.search(search)
    if search
      where('email LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
