class Mailalias < ActiveRecord::Base

  # Relationships
  belongs_to :domain

  # Attributes
  attr_accessible :domain_id, :source, :destination

  # Callbacks
  before_save :append_domain
  after_find :remove_domain

  # Validations
  validates_presence_of :domain_id, :source, :destination
  validate :source_format

  set_table_name "virtual_aliases"

  # Validation:
  # Checks whether source email address contains @domain.com
  def source_format
    errors.add(:email, "format is invalid") if domain_present
  end

  def self.search(search)
    if search
      where('source LIKE ? OR destination LIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end

  private

  def append_domain
    self.source = [self.source, self.domain.name].join("@")
  end

  def remove_domain
    if domain_present
      self.source = self.source.gsub(/@[a-z.]*/, '')
    end

    self.source
  end

  def domain_present
    scanner = self.source.scan(/@[a-z.]*/)
    if scanner.size > 0
      true
    else
      false
    end
  end

end
