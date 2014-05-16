class Entry

  include Mongoid::Document

  field :name, type: String
  field :price, type: Integer
  field :flag, type: Mongoid::Boolean

  validates :name, presence: true

end
