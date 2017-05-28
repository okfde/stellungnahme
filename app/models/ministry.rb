class Ministry < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :slug

  has_and_belongs_to_many :laws
end
