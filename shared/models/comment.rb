
class Comment
  include DataMapper::Resource
  property :id, Serial
  property :poster, String
  property :body, String
end
