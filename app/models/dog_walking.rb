class DogWalking < ApplicationRecord
  validates :duration,
            inclusion: { in: [30, 60], allow_nil: false, only_integer: true },
            presence: true
  validates :pets, numericality: { only_integer: true }, presence: true

  enum status: { pending: 0, in_progress: 1, finished: 2 }

  scope :next_walks, lambda {
    where('status != ? AND scheduled_day >= ?', 2, Date.today)
  }
end
