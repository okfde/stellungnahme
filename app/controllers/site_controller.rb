class SiteController < ApplicationController
  def index
    @org_count = 42 # FIXME
    @law_count = Law.count
    @first_comment = Comment.order(asked_at: :asc).first || OpenStruct.new(asked_at: 5.years.ago)
  end
end
