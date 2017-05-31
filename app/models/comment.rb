class Comment < ApplicationRecord
  belongs_to :law
  belongs_to :draft_law
  belongs_to :document
end
