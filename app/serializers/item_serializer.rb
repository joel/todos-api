class ItemSerializer
  include JSONAPI::Serializer

  attribute :name
  attribute :done
end
