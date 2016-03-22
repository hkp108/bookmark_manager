require 'data_mapper'
require 'dm-postgres-adapter'

class Bookmarks
  include DataMapper::Resource

  property :id,    Serial
  property :url,   String
  property :title, String
  # property :description, String
  # property :tag, String

end

DataMapper.setup(:default,'postgres://localhost/bookmarks')
DataMapper.finalize
DataMapper.auto_upgrade!
