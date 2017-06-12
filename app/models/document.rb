class Document < ApplicationRecord
  mount_uploader :file, DocumentUploader
  before_save :update_file_attributes

  def source_url=(url)
    write_attribute(:source_url, url)
    self.remote_file_url = url
  end

  private

  def update_file_attributes
    if file.present? && file_changed?
      self.filetype = file.file.content_type
      self.filesize = file.file.size
    end
  end
end
