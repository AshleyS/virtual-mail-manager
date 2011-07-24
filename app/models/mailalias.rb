class Mailalias < ActiveRecord::Base
  belongs_to :domain

  validates_presence_of :domain_id, :source, :destination

  attr_accessible :domain_id, :source, :destination

  def self.search(search)
    if search
      where('source LIKE ? OR destination LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

end
