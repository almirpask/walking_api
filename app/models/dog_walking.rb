class DogWalking < ApplicationRecord
  enum status: { pending: 0, in_progress: 1, finished: 2 }

  scope :next_walks, -> { where('status != ? AND scheduled_day >= ?', 2, Date.today.to_datetime) }
end
