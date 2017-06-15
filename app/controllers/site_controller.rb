class SiteController < ApplicationController
  def index
    @org_count = Organization.count
    @law_count = Law.count
    @comment_count = Comment.count

    @letters = {}
    lttr = (('a'..'z').to_a + %w(ä ü ö))
    ICU::Collation.collate('de', lttr).map { |l| @letters[l] = l.downcase }
    @letters['ä'] = 'ae'
    @letters['ü'] = 'ue'
    @letters['ö'] = 'oe'

    @letter = params[:letter] || 'a'
    raise ArgumentError, 'letter must be a single char' if @letter.size > 2
    raise ArgumentError, 'letter unknown' unless @letters.values.include? @letter

    case @letter
    when 'ae'
        @letter = 'ä'
    when 'ue'
        @letter = 'ü'
    when 'oe'
        @letter = 'ö'
    end

    @orgs = Organization.where('LOWER(name) LIKE ?', @letter.downcase + '%')
  end

  def status
    expires_now
    render plain: "OK - #{Time.now}"
  end
end
