class AccelerationEntry
  include Mongoid::Document

  embedded_in :handshake

  field :x, type:  BigDecimal
  field :y, type:  BigDecimal
  field :z, type:  BigDecimal
  field :timestamp, type: DateTime
end