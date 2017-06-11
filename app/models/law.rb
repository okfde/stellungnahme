class Law < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates_presence_of :title, :slug
  validates :title, uniqueness: true

  has_and_belongs_to_many :ministries
  has_many :drafts, dependent: :destroy
  has_many :comments, dependent: :destroy
end
