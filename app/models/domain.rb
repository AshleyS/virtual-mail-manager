class Domain < ActiveRecord::Base
  has_many :mailboxes
  has_many :mailaliases

  validates_presence_of :domain

  attr_accessible :domain

  def self.search(search)
    if search
      where('domain LIKE ? ', "%#{search}%")
    else
      scoped
    end
  end

end
