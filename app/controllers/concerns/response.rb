module Response
  def json_response(relation:, status: :ok, is_collection: false)
    render json: JSONAPI::Serializer.serialize(relation, is_collection: is_collection), status: status
  end
end
