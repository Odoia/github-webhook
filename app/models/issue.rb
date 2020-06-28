class Issue < ApplicationRecord
  has_many :comments
  has_many :status
end
