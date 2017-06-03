class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :slug

  has_and_belongs_to_many :comments

  def laws
    comments.map(&:law).uniq
  end
end
