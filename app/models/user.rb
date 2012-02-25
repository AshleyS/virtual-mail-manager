class User < ActiveRecord::Base

  # Relationships
  has_many :administrations
  has_many :domains, :through => :administrations

  # Attributes
  attr_accessible :username, :password, :password_confirmation
  attr_accessor :password

  # Callbacks
  before_save :encrypt_password

  # Validations
  validates_confirmation_of :password, :on => :create
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_uniqueness_of :username

  # User authentication
  def self.authenticate(username, password)
    user = find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      # Update the user's last login
      user.update_last_login
      user
    else
      nil
    end
  end

  # Password encryption
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  # Search
  def self.search(search)
    if search
      where('username LIKE ? ', "%#{search}%")
    else
      scoped
    end
  end

  # Update user's last login date
  def update_last_login
    login_time = Time.now
    logger.debug "login time: " + login_time.to_s

    self.last_login = login_time
    self.save!

    logger.debug "saved"

  end

end
