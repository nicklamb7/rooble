class Type < ApplicationRecord
  belongs_to :user
  has_many :functions
end
