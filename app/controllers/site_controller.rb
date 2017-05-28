class SiteController < ApplicationController
  def index
    @org_count = 42 # FIXME
    @law_count = Law.count
  end
end
