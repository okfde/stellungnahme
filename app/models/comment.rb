class Comment < ApplicationRecord
  belongs_to :law
  belongs_to :document
end
