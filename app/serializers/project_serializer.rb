class ProjectSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description, :created_at
end
