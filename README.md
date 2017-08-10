# README

This README would normally document whatever steps are necessary to get the
application up and running.

Simple Todo list in rails --api app. Following JSON API Structure.

# Create a Todo list

```
require 'net/http'
require 'uri'

# CREATE TODO

uri = URI.parse("http://localhost:3000/todos")

request = Net::HTTP::Post.new(uri)
request["content-type"] = "application/json"

data = { "data" => {
  "type" => 'todos',
  "attributes" => {
    "title"      => "Bucket List",
    "created_by" => "Joel AZEMAR"
}}}

request.body = data.to_json

req_options = { use_ssl: uri.scheme == "https" }

response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  http.request(request)
end

JSON.load(response.body)
```

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

```
# Add User
> createuser -D -A -P postgres_default_user

# Add Database
> createdb -O postgres_default_user -E UTF8 todo_api_sample_development

# psql todo_api_sample_development
> ALTER USER postgres_default_user CREATEDB;

# psql template1
> alter role postgres_default_user with superuser;
```

`bundle exec rake db:migrate`

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
