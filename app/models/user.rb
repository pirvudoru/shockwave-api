class User < ActiveRecord::Base
  include Mongoid::Document
  field :name, type: String
end
