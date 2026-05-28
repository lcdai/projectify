class ProjectSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :title, :description, :created_at
end
