class Draft < ApplicationRecord
  belongs_to :law
  belongs_to :document

  validates_presence_of :law, :document
end
