class ImportDetail < ApplicationRecord
  PENDING = 'pending'.freeze
  PROCESSING = 'processing'.freeze
  COMPLETED = 'completed'.freeze
  ERROR = 'error'.freeze

  validates :uuid, presence: true
  validates :headers, presence: true
  validates :data, presence: true
  validates :status, presence: true

  enum status: [
    PENDING,
    PROCESSING,
    COMPLETED,
    ERROR,
  ]

  has_many :orders
end
