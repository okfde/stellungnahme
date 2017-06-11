class Law < ApplicationRecord
  extend FriendlyId
  friendly_id :id_and_title, use: :slugged
  validates_presence_of :title, :slug
  validates :title, uniqueness: true

  has_and_belongs_to_many :ministries
  has_many :drafts, dependent: :destroy
  has_many :comments, dependent: :destroy

  def should_generate_new_friendly_id?
    title_changed? || super
  end

  def id_and_title
    [
      [:id, :title]
    ]
  end

  def normalize_friendly_id(value)
    value.to_s.gsub('&', 'und').parameterize.truncate(120, separator: '-', omission: '')
  end
end
