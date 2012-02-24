class Mailalias < ActiveRecord::Base
  belongs_to :domain

  validates_presence_of :domain_id, :source, :destination

  attr_accessible :domain_id, :source, :destination

  set_table_name "virtual_aliases"

  def self.search(search)
    if search
      where('source LIKE ? OR destination LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

end
