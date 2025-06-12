class Employee < ApplicationRecord
  has_many :feedbacks, dependent: :destroy
end
