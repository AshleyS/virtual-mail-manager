class Domain < ActiveRecord::Base
  has_many :mailboxes
  has_many :mailaliases

  has_many :administrations
  has_many :users, :through => :administrations

  validates_presence_of :name, :max_mailboxes, :max_mailaliases
  validates_numericality_of :max_mailboxes, :max_mailaliases
  validates_uniqueness_of :name

  attr_accessible :name, :max_mailboxes, :max_mailaliases

  self.table_name = "virtual_domains"

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
