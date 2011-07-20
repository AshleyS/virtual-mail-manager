class Mailbox < ActiveRecord::Base
  belongs_to :domain

  validates_presence_of :domain_id, :email
end
