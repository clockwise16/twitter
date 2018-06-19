DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/Twitter.db")

class Tweet
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :content, Text #256자
  property :created_at, DateTime
end

class User
  include DataMapper::Resource
  property :id, Serial
  property :email, String
  property :password, String
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Tweet.auto_upgrade!
User.auto_upgrade!
