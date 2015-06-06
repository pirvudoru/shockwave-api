class Handshake
  include Mongoid::Document

  belongs_to :user
  embeds_many :acceleration_entries
  field :timestamp, type: DateTime
  field :location, type: Array #longitude then latitude

  index({ location: '2d'}, { min: -200, max: 200 })

  accepts_nested_attributes_for :acceleration_entries
end