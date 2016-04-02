class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 10}, presence: true
  validates :user, presence: true
  scope :visible_to, -> (user) {user ? all : where(private: false)}
end
