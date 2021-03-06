require 'data_mapper'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/main_database.db")

class Message
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :email, Text, required: true
  property :subject, Text
  property :content, Text, required: true
  property :created_at, DateTime
end

class BlogPost
  include DataMapper::Resource
  property :id, Serial
  property :title, String, required: true
  property :author, String, required: true
  property :content, Text, required: true
  property :url_title, String, unique: true
  property :created_at, DateTime
  property :updated_at, DateTime

  has n, :comments
end

class Comment
  include DataMapper::Resource
  property :id, Serial
  property :blog_post_id, Integer
  property :author, String, default: 'Anonymous'
  property :created_at, DateTime
  property :content, Text, required: true 

  belongs_to :blog_post
end

DataMapper.finalize.auto_upgrade!
