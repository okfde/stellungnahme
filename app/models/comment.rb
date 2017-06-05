class Comment < ApplicationRecord
  belongs_to :law
  belongs_to :draft
  belongs_to :document, optional: true

  has_and_belongs_to_many :organizations
end
