class Domain < ActiveRecord::Base
  has_many :mailboxes
  has_many :mailaliases

  validates_presence_of :name, :max_mailboxes, :max_mailaliases
  validates_numericality_of :max_mailboxes, :max_mailaliases

  attr_accessible :name, :max_mailboxes, :max_mailaliases

  def self.search(search)
    if search
      where('name LIKE ? ', "%#{search}%")
    else
      scoped
    end
  end

  def deletable?
    if mailboxes.size == 0 && mailaliases.size == 0 then
      true
    else
      false
    end
  end

end
