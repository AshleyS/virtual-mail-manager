class Mailbox < ActiveRecord::Base

  # Relationships
  belongs_to :domain

  # Attributes
  attr_accessible :domain_id, :email, :password

  # Callbacks
  before_save :encrypt_password, :append_domain
  after_find :remove_domain

  # Validations
  validates_presence_of :domain_id, :email
  validate :email_format
  validate :email_unique

  set_table_name "virtual_users"

  # Validation:
  # Checks whether email address has been added
  def email_format
    errors.add(:email, "format is invalid") if domain_present
  end

  # Validation:
  # Uses email manipulation to check to ensure email is unique
  def email_unique
    before_email = self.email

    email_to_test = self.append_domain

    if self.id
      # If editing, then exclude the object from the query
      results = Mailbox.where(:email => email_to_test).where("id != ?", self.id)
    else
      results = Mailbox.where(:email => email_to_test)
    end

    if results.count > 0
      errors.add(:email, "is already in use")
    end

    self.email = before_email
  end

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

  def append_domain
    self.email = [self.email, self.domain.name].join("@")
  end

  def remove_domain
    if domain_present
      self.email = self.email.gsub(/@[a-z.]*/, '')
    end

    self.email
  end

  def domain_present
    scanner = self.email.scan(/@[a-z.]*/)
    if scanner.size > 0
      true
    else
      false
    end
  end

end
