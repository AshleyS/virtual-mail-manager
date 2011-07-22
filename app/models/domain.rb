class Domain < ActiveRecord::Base
  has_many :mailboxes
  has_many :mailaliases

  validates_presence_of :domain
end
