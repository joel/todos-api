class TodoSerializer
  include JSONAPI::Serializer

  attribute :title
  attribute :created_by

  has_many :items
end
