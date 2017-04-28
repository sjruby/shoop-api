class BoardSerializer < ActiveModel::Serializer
  attributes :id, :title, :cells
end
