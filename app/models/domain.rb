class Domain < ActiveRecord::Base
  has_many :mailboxes
  has_many :mail_aliases

  validates_presence_of :domain
end
