class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :phone_number, type: String
  has_many :handshakes

  has_and_belongs_to_many :acquaintances, class_name: 'User'
end
