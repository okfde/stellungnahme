class Organization < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :slug

  has_and_belongs_to_many :comments

  def laws
    comments.map(&:law).uniq
  end


  def self.normalize(name)
    config = {
      host: Rails.configuration.x.nomenklatura_host,
      api_key: Rails.application.secrets.nomenklatura_apikey
    }
    return name if config[:host].blank? || config[:api_key].blank?
    ::Nomenklatura::Dataset.new('draft-law-comment-sources', config).lookup(name)
  end
end
