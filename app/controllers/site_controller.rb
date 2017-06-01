class SiteController < ApplicationController
  def index
    @org_count = Organization.count
    @law_count = Law.count
    @first_comment = Comment.order(asked_at: :asc).first || OpenStruct.new(asked_at: 5.years.ago)

    @letter = 'A'
    @orgs = Organization.where("LOWER(name) LIKE ?", @letter.downcase + '%')
  end
end
