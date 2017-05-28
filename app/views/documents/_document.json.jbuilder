json.extract! document, :id, :source_url, :contents, :filetype, :filesize, :created_at, :updated_at
json.url document_url(document, format: :json)
