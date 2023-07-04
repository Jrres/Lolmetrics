class Champion < ApplicationRecord
validates :name, presence: true
  validates :win, presence: true
  validates :loss, presence: true
  validates :firstrune, presence: true, length: { minimum: 10 }
  validates :secondrune, presence: true, length: { minimum: 10 }
  validates :thirdrune, presence: true, length: { minimum: 10 }
  validates :fourthrune, presence: true, length: { minimum: 10 }
end
