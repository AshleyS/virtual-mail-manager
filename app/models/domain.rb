class Domain < ActiveRecord::Base
  has_many :mailboxes
  has_many :mailaliases

  validates_presence_of :name

  attr_accessible :name

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
