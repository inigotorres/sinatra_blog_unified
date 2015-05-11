require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/main_database.db")

class Message
    include DataMapper::Resource
    property :id, Serial
    property :name, Text
    property :email, Text, :required => true
    property :subject, Text
    property :content, Text, :required => true
    property :created_at, DateTime
end
  
class BlogPost
  include DataMapper::Resource
  property :id, Serial
  property :title, String, :required => true
  property :author, String, :required => true
  property :content, Text, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

