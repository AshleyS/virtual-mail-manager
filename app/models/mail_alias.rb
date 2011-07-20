class MailAlias < ActiveRecord::Base
  belongs_to :domain

  validates_presence_of :domain_id, :source, :destination
end
