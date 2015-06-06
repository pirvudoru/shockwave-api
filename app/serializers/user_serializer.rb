class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone_number
  root false

  def id
    object._id.to_s
  end
end