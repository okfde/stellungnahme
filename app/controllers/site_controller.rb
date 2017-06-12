class SiteController < ApplicationController
  def index
    @org_count = Organization.count
    @law_count = Law.count
    @first_comment = Comment.order(asked_at: :asc).first || OpenStruct.new(asked_at: 5.years.ago)

    @letters = {}
    lttr = (('A'..'Z').to_a + %w(Ä Ü Ö))
    ICU::Collation.collate('de', lttr).map { |l| @letters[l] = l.downcase }
    @letters['Ä'] = 'ae'
    @letters['Ü'] = 'ue'
    @letters['Ö'] = 'oe'

    @letter = params[:letter] || 'A'
    raise ArgumentError, 'letter must be a single char' if @letter.size > 2
    raise ArgumentError, 'letter unknown' unless @letters.values.include? @letter

    case @letter
    when 'ae'
        @letter = 'Ä'
    when 'ue'
        @letter = 'Ü'
    when 'oe'
        @letter = 'Ö'
    end

    @orgs = Organization.where('LOWER(name) LIKE ?', @letter.downcase + '%')
  end
end
