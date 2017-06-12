class Draft < ApplicationRecord
  belongs_to :law
  belongs_to :document
  accepts_nested_attributes_for :document

  validates_presence_of :law, :document

  has_many :comments, dependent: :destroy
end
