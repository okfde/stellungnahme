class Comment < ApplicationRecord
  belongs_to :law
  belongs_to :draft_law
  belongs_to :document

  has_and_belongs_to_many :organizations
end
