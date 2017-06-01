class SiteController < ApplicationController
  def index
    @org_count = Organization.count
    @law_count = Law.count
    @first_comment = Comment.order(asked_at: :asc).first || OpenStruct.new(asked_at: 5.years.ago)

    @letters = (('A'..'Z').to_a + %w(Ä Ü Ö))
    @letters = ICU::Collation.collate('de', @letters)

    @letter = params[:letter] || 'A'
    raise ArgumentError, 'letter must be a single char' if @letter.size != 1

    @orgs = Organization.where('LOWER(name) LIKE ?', @letter.downcase + '%')
  end
end
